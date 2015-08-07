//
//  ViewController.h
//  Photorama
//
//  Created by Nikita Rau on 6/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoStore;

@interface PhotosViewController : UIViewController <UICollectionViewDelegate>
@property (strong, nonatomic) PhotoStore *photoStore;
@end

