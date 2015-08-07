//
//  PhotoStore.h
//  Photorama
//
//  Created by Nikita Rau on 6/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Photo;
@class CoreDataStack;

@interface PhotoStore : NSObject

@property (strong, nonatomic) CoreDataStack *cdStack;

- (void)fetchRecentPhotosWithCompletion:(void(^)(NSArray *))completion;
- (void)fetchImageForPhoto: (Photo *)photo completion:(void(^)(UIImage *))completion;

@end
