//
//  ItemsViewController.m
//  Homepwner
//
//  Created by Nikita Rau on 6/22/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "ItemsViewController.h"
#import "ItemStore.h"
#import "Item.h"
#import "ItemCell.h"
#import "DetailViewController.h"
#import "ImageStore.h"

@interface ItemsViewController ()
@property (nonatomic) ItemStore *itemStore;
@property (nonatomic) IBOutlet UIView *headerView;
@property (nonatomic) ImageStore *imageStore;
@end

@implementation ItemsViewController

- (IBAction)addItemButtonPressed:(id)sender {
    [self presentDetailForNewItem];
}

- (void)presentDetailForNewItem {
    DetailViewController *dvc = [[DetailViewController alloc] initWithItem:nil
                                 imageStore:self.imageStore];
    dvc.cancelBlock = ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    dvc.saveBlock = ^(Item *newItem){
        [self  dismissViewControllerAnimated:YES completion:^{
            // Insert the item into the store
            [self.itemStore insertItem:newItem];
            
            // Insert a cell for the item into the table view
            NSUInteger index = [self.itemStore.allItems indexOfObjectIdenticalTo:newItem];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        }];
    };
    
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:dvc];
    nc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:nc animated:YES completion:nil];
}

- (instancetype)initWithItemStore:(ItemStore *)store
                       imageStore:(ImageStore *)images {
    self = [super initWithNibName:nil bundle:nil]; // call super's designated init
    if (self) {
        self.itemStore = store;
        self.imageStore = images;
        self.navigationItem.title = NSLocalizedString(@"Homepwner", @"Name of the application");
        
        // Create a new bar button item that will send addNewItem: to this VC
        UIBarButtonItem *barItem =
        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                      target:self
                                                      action:@selector(addItemButtonPressed:)];
        
        // Set barItem as the rightmost button in the nav bar for this VC
        self.navigationItem.rightBarButtonItem = barItem;
        
        self.navigationItem.leftBarButtonItem = [self editButtonItem];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemStore.allItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get a new or recycled cell
    ItemCell *cell =
    [self.tableView dequeueReusableCellWithIdentifier:@"ItemCell" forIndexPath:indexPath];
    
    // Configure the cell withe the Item's properties
    Item *item = self.itemStore.allItems[indexPath.row];
    cell.nameLabel.text = item.itemName;
    cell.serialNumberLabel.text = item.serialNumber;
    NSNumberFormatter *currencyFormatter = [[NSNumberFormatter alloc] init];
    currencyFormatter.numberStyle = NSNumberFormatterCurrencyStyle;
    cell.valueLabel.text = [currencyFormatter stringFromNumber:@(item.valueInDollars)];
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load the ItemCell nib
    UINib *itemCellNib = [UINib nibWithNibName:@"ItemCell" bundle:nil];
    // Register this nib as the template for new ItemCells
    [self.tableView registerNib:itemCellNib forCellReuseIdentifier:@"ItemCell"];
}

- (void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath {
    // If the table is asking to commit a delete operation...
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Find the item to delete and remove it from the ItemStore
        Item *item = self.itemStore.allItems[indexPath.row];
        
        
        NSString *title = [NSString stringWithFormat:@"Delete %@?", item.itemName];
        NSString *message = @"Are you sure you want to delete this item?";
        
        UIAlertController *ac =
        [UIAlertController alertControllerWithTitle:title
                                            message:message
                                     preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction =
        [UIAlertAction actionWithTitle:@"Cancel"
                                 style:UIAlertActionStyleCancel
                               handler:nil];
         [ac addAction:cancelAction];
         
         UIAlertAction *deleteAction =
         [UIAlertAction actionWithTitle:@"Delete"
                                  style:UIAlertActionStyleDestructive
                                handler:^(UIAlertAction *action) {
                                   
            [self.itemStore removeItem:item];
            
            // Also remove its image from the image store
            [self.imageStore setImage:nil forKey:item.itemKey];
            
            // Find the item to delete and remove it from the table
            [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                                  withRowAnimation:UITableViewRowAnimationFade];
        }];
        [ac addAction:deleteAction];
        
        // Use popover whenever possible (regular width environments)
        ac.modalPresentationStyle = UIModalPresentationPopover;
        
        // Configure popover properties
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        if (cell) {
            ac.popoverPresentationController.sourceView = cell;
            ac.popoverPresentationController.sourceRect = cell.bounds;
        }
        
        // Present the alert controller
        [self presentViewController:ac animated:YES completion:nil];
    }
}

- (void)tableView:(UITableView *)tableView
moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
      toIndexPath:(NSIndexPath *)destinationIndexPath {
    // Update the array
    [self.itemStore moveItemAtIndex:sourceIndexPath.row
                            toIndex:destinationIndexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Get the item for the selected row
    Item *itemToShow = self.itemStore.allItems[indexPath.row];
    
    // Create a detail view controller
    DetailViewController *dvc = [[DetailViewController alloc] initWithItem:itemToShow
                                 imageStore:self.imageStore];
    
    // Push it onto the navigation stack
    [self showViewController:dvc sender:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

@end
