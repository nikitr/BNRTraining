//
//  Photo.h
//  Photorama
//
//  Created by Nikita Rau on 6/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface Photo : NSManagedObject

@property(strong, nonatomic) NSString *title;
@property(strong, nonatomic) NSURL *url;
@property(strong, nonatomic) NSString *photoID;
@property(strong, nonatomic) NSDate *dateTaken;
@property(strong, nonatomic) NSString *photoKey;
@property(strong, nonatomic) NSSet *tags;
@property(strong, nonatomic) UIImage *image;

- (void)addTagObject:(NSManagedObject *)tag;
- (void)removeTagObject:(NSManagedObject *)tag;

@end
