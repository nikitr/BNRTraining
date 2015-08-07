//
//  PhotoCollectionViewCell.m
//  Photorama
//
//  Created by Nikita Rau on 6/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "PhotoCollectionViewCell.h"

@implementation PhotoCollectionViewCell

- (void)updateWithImage:(UIImage *)image {
    if (image != nil) {
        [self.spinner stopAnimating];
    } else {
        [self.spinner startAnimating];
    }
    
    self.imageView.image = image;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self updateWithImage:nil];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self updateWithImage:nil];
}

@end
