//
//  PhotoCollectionViewCell.h
//  Photorama
//
//  Created by Nikita Rau on 6/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoCollectionViewCell : UICollectionViewCell

@property(weak, nonatomic) IBOutlet UIImageView *imageView;
@property(weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

- (void)updateWithImage:(UIImage *)image;

@end
