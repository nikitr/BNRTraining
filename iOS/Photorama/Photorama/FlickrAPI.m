//
//  FlickrAPI.m
//  Photorama
//
//  Created by Nikita Rau on 6/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "FlickrAPI.h"
#import "Photo.h"

NSString * const APIKey = @"a6d819499131071f158fd740860a5a88";
NSString * const BaseURLString = @"https://api.flickr.com/services/rest";
NSString * const RecentPhotosMethod = @"flickr.photos.getRecent";

@implementation FlickrAPI

+ (NSURL *)recentPhotosURL {
    NSDictionary *parameters = @{@"extras":@"url_h,date_taken"};
    NSURL *url = [self flickrURLForMethod:RecentPhotosMethod
                               parameters:parameters];
    return url;
}

+ (NSURL *)flickrURLForMethod:(NSString *)method
                   parameters:(NSDictionary *)params {
    
    NSURLComponents *components = [NSURLComponents componentsWithString:BaseURLString];
    NSMutableArray *queryItems = [NSMutableArray array];
    
    NSMutableDictionary *allParams = [@{ @"method" : method,
                                         @"format" : @"json",
                                         @"nojsoncallback" : @"1",
                                         @"api_key" : APIKey } mutableCopy];
    
    [allParams addEntriesFromDictionary:params];
    
    for (NSString *queryKey in allParams.allKeys) {
        NSURLQueryItem *queryItem = [NSURLQueryItem queryItemWithName:queryKey
                                                                value:allParams[queryKey]];
        [queryItems addObject:queryItem];
    }
    
    components.queryItems = queryItems;
    
    return components.URL;
}

+ (NSArray *)photosFromJSONData:(NSData *)jsonData
inContext:(NSManagedObjectContext *)context{
    
    NSMutableArray *photos = [NSMutableArray array];
    
    NSError *parseError = nil;
    NSDictionary *jsonObject =
    [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&parseError];
    
    if (jsonObject != nil) {
        NSDictionary *jsonPhotosDict = jsonObject[@"photos"];
        NSArray *jsonPhotosArray = jsonPhotosDict[@"photo"];
        for (NSDictionary *jsonSinglePhotoDict in jsonPhotosArray) {
            NSLog(@"Photo: %@", jsonSinglePhotoDict);
            Photo *photo = [FlickrAPI photoFromJSON:jsonSinglePhotoDict inContext:context];
            if (photo) {
                [photos addObject:photo];
            }
        }
    } else {
        NSLog(@"Failed to parse JSON data. Error: %@", parseError.localizedDescription);
    }
    
    return photos; // returning empty array for now
}

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [NSDateFormatter new];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    });
    return formatter;
}

+ (Photo *)photoFromJSON:(NSDictionary *)jsonDict
               inContext:(NSManagedObjectContext *)context {
    
    NSString *photoID = jsonDict[@"id"];
    NSString *title = jsonDict[@"title"];
    NSURL *URL = [NSURL URLWithString:jsonDict[@"url_h"]];
    NSDate *dateTaken = [[FlickrAPI dateFormatter] dateFromString:jsonDict[@"datetaken"]];
    
    if (!photoID || !title || !URL || !dateTaken) {
        return nil;
    }
    
    __block Photo *photo = nil;
    [context performBlockAndWait:^{
        photo = [NSEntityDescription insertNewObjectForEntityForName: @"Photo"
                                              inManagedObjectContext:context];
        photo.title = title;
        photo.photoID = photoID;
        photo.url = URL;
        photo.dateTaken = dateTaken;
    }];
    
    return photo;
}

@end
