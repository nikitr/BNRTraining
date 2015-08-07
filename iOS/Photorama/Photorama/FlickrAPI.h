//
//  FlickrAPI.h
//  Photorama
//
//  Created by Nikita Rau on 6/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

@interface FlickrAPI : NSObject
+ (NSURL *)recentPhotosURL;
+ (NSArray *)photosFromJSONData:(NSData *)jsonData
                      inContext:(NSManagedObjectContext *)context;
@end
