//
//  ItemsViewController.h
//  Homepwner
//
//  Created by Nikita Rau on 6/22/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ItemStore;
@class ImageStore;

@interface ItemsViewController : UITableViewController

- (instancetype)initWithItemStore:(ItemStore *)store imageStore:(ImageStore *)images;

@end
