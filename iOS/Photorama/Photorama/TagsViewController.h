//
//  TagsViewController.h
//  Photorama
//
//  Created by Nikita Rau on 6/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PhotoStore.h"
#import "Photo.h"

@interface TagsViewController : UITableViewController

@property(strong, nonatomic) PhotoStore *photoStore;
@property(strong, nonatomic) Photo *photo;
@property(strong, nonatomic) NSMutableArray *selectedIndexPaths;

@end
