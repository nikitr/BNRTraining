//
//  DetailViewController.m
//  Homepwner
//
//  Created by Nikita Rau on 6/22/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "DetailViewController.h"
#import "Item.h"
#import "ImageStore.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraItem;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@property (nonatomic) Item *item;
@property (nonatomic) ImageStore *imageStore;
@end

@implementation DetailViewController
- (IBAction)backgroundTapped:(id)sender {
    [self.view endEditing:YES];
}

- (instancetype)initWithItem:(Item *)item
                  imageStore:(ImageStore *)images{
    self = [super initWithNibName:@"DetailViewController" bundle:nil];
    if (self) {
        self.item = item;
        self.navigationItem.title = item.itemName;
        self.imageStore = images;
        
        if (item == nil) {
            // We weren't given an item so make an empty one.
            self.item = [[Item alloc] init];
            
            // Since this is a new item, provide Cancel and Done navigation items
            UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
            self.navigationItem.leftBarButtonItem = cancelItem;
            
            UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
            self.navigationItem.rightBarButtonItem = doneItem;
        } else {
            // Otherwise, just provide the defaults
            self.navigationItem.leftBarButtonItem = self.navigationItem.backBarButtonItem;
            self.navigationItem.rightBarButtonItem = nil;
        }
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // import values from the current item into the UI
    self.nameField.text = self.item.itemName;
    self.serialNumberField.text = self.item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", self.item.valueInDollars];
    
    // represent the date created legibly
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterMediumStyle;
    dateFormatter.timeStyle = NSDateFormatterNoStyle;
    self.dateLabel.text = [dateFormatter stringFromDate:self.item.dateCreated];
    
    // Display the items image, if there is one for it in the image store
    UIImage *itemImage = [self.imageStore imageForKey:self.item.itemKey];
    self.imageView.image = itemImage;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Clear first responder
    [self.view endEditing:YES];
    
    // Update the item with the text field contents
    self.item.itemName = self.nameField.text;
    self.item.serialNumber = self.serialNumberField.text;
    self.item.valueInDollars = [self.valueField.text intValue];
}

- (IBAction)pictureButtonPressed:(UIBarButtonItem *)sender {
    [self takePicture];
}

- (void)takePicture {
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    
    // If the decide has a camera, take a picture
    // Otherwise, pick from the library.
    if ([UIImagePickerController
         isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    ipc.delegate = self;
    
    // put the image picker on the screen
    ipc.modalPresentationStyle = UIModalPresentationPopover;
    ipc.popoverPresentationController.barButtonItem = self.cameraItem;
    [self presentViewController:ipc animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Get the chosen image from the info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // Store the image in the image store
    [self.imageStore setImage:image forKey:self.item.itemKey];
    
    // Put the image into the image view
    self.imageView.image = image;
    
    // Dismiss the image picker
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)cancel:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

- (void)save:(id)sender {
    if (self.saveBlock) {
        self.saveBlock(self.item);
    }
}

@end
