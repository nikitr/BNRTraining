//
//  PhotoInfoViewController.h
//  Photorama
//
//  Created by Nikita Rau on 6/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Photo;
@class PhotoStore;

@interface PhotoInfoViewController : UIViewController
@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property(strong, nonatomic) Photo *photo;
@property(strong, nonatomic) PhotoStore *photoStore;
@end
