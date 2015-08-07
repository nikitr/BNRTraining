//
//  TagsViewController.m
//  Photorama
//
//  Created by Nikita Rau on 6/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "TagsViewController.h"
#import "TagDataSource.h"
#import "CoreDataStack.h"

@interface TagsViewController ()
@property (strong, nonatomic) TagDataSource *tagDataSource;
@end

@implementation TagsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tagDataSource =
    [[TagDataSource alloc] initWithContext:self.photoStore.cdStack.mainQContext];
    self.tableView.dataSource = self.tagDataSource;
    self.tableView.delegate = self;
    self.selectedIndexPaths = [NSMutableArray array];
    
    for (NSManagedObject *tag in self.photo.tags) {
        NSUInteger index = [self.tagDataSource.tags indexOfObject:tag];
        if (index != NSNotFound) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
            [self.selectedIndexPaths addObject:indexPath];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSManagedObject *tag = self.tagDataSource.tags[indexPath.row];
    
    NSUInteger index = [self.selectedIndexPaths indexOfObject:indexPath];
    if (index != NSNotFound) {
        [self.selectedIndexPaths removeObjectAtIndex:index];
        [self.photo removeTagObject:tag];
    } else {
        [self.selectedIndexPaths addObject:indexPath];
        [self.photo addTagObject:tag];
    }
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSError *saveError = nil;
    if (![self.photoStore.cdStack saveChanges:&saveError]) {
        NSLog(@"Failed to save the store: %@", saveError);
    }
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger index = [self.selectedIndexPaths indexOfObject:indexPath];
    if (index != NSNotFound) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

// MARK: Actions
- (IBAction)addNewTag:(UIBarButtonItem *)sender {
    UIAlertController *alertController =
    [UIAlertController alertControllerWithTitle:@"Add Tag"
                                        message:nil
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"tag label";
        textField.autocapitalizationType = UITextAutocapitalizationTypeWords;
    }];
    
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           NSString *tagName = [alertController.textFields.firstObject text];
                                                           NSManagedObjectContext *ctx = self.photoStore.cdStack.mainQContext;
                                                           NSManagedObject *newTag =
                                                           [NSEntityDescription insertNewObjectForEntityForName:@"Tag" inManagedObjectContext:ctx];
                                                           [newTag setValue:tagName forKey:@"name"];
                                                           
                                                           NSError *saveError = nil;
                                                           if (![self.photoStore.cdStack saveChanges:&saveError]) {
                                                               NSLog(@"Failed to save the store: %@", saveError);
                                                           }
                                                           
                                                           [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
                                                           
                                                       }];
    [alertController addAction:okayAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (IBAction)done:(UIBarButtonItem *)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
