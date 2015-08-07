//
//  DetailViewController.h
//  Homepwner
//
//  Created by Nikita Rau on 6/22/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ItemStore;
@class Item;
@class ImageStore;

@interface DetailViewController : UIViewController
<UINavigationControllerDelegate, UIImagePickerControllerDelegate,UITextFieldDelegate>

@property (nonatomic, copy) void (^cancelBlock)(void);
@property (nonatomic, copy) void (^saveBlock)(Item *);
- (instancetype)initWithItem:(Item *)item imageStore:(ImageStore *)images;

@end
