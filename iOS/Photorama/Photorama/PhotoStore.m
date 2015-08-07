//
//  PhotoStore.m
//  Photorama
//
//  Created by Nikita Rau on 6/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "PhotoStore.h"
#import "FlickrAPI.h"
#import "Photo.h"
#import "CoreDataStack.h"
#import "ImageStore.h"

@interface PhotoStore ()
@property (strong, nonatomic) NSURLSession *session;
@property (strong, nonatomic) ImageStore *imageStore;
@end

@implementation PhotoStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config =
        [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
        
        _cdStack = [[CoreDataStack alloc] initWithModelName:@"Photorama"];
        
        _imageStore = [ImageStore new];
    }
    return self;
}

- (void)fetchRecentPhotosWithCompletion:(void(^)(NSArray *photos))completion {
    NSURL *url = [FlickrAPI recentPhotosURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask *task =
    [self.session dataTaskWithRequest:request
                    completionHandler:^(NSData *data,
                                        NSURLResponse *response,
                                        NSError *error) {
                        NSArray *photos = nil;
                        if (data != nil) {
                            photos = [FlickrAPI photosFromJSONData:data inContext:self.cdStack.mainQContext];
                            NSLog(@"%@", photos);
                            NSError *saveError = nil;
                            if (![self.cdStack saveChanges:&saveError]) {
                                NSLog(@"Failed to save the store! Error: %@",
                                      saveError.localizedDescription);
                            }
                        } else {
                            NSLog(@"Failed to fetch data. Error: %@", error.localizedDescription);
                        }
                        
                        if (completion) {
                            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                completion(photos);
                            }];
                        }
                    }];
    [task resume];
}

- (void)fetchImageForPhoto:(Photo *)photo
                completion:(void(^)(UIImage *))completion {
    
    if ([self.imageStore imageForKey:photo.photoKey] != nil && completion != nil) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                                              completion(photo.image);
                                                              }];
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:photo.url];
    NSURLSessionDownloadTask *task =
    [self.session downloadTaskWithRequest:request
                        completionHandler:^(NSURL *location,
                                            NSURLResponse *response,
                                            NSError *error) {
                            UIImage *image = nil;
                            if (location != nil) {
                                NSData *imageData = [NSData dataWithContentsOfURL:location];
                                image = [UIImage imageWithData:imageData];
                                photo.image = image;
                                [self.imageStore setImage:image forKey:photo.photoKey];
                            } else {
                                NSLog(@"Failed to download image at %@: %@",
                                      photo.url, error.localizedDescription);
                            }
                            
                            if (completion) {
                                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                                    completion(image);
                                }];
                            }
                        }];
    [task resume];
}

@end
