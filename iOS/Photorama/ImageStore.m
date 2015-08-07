//
//  ImageStore.m
//  Homepwner
//
//  Created by Nikita Rau on 6/22/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "ImageStore.h"

@interface ImageStore ()
@property (nonatomic) NSMutableDictionary *imageDictionary;
@end

@implementation ImageStore

- (instancetype)init {
    self = [super init];
    if (self) {
        self.imageDictionary = [NSMutableDictionary dictionary];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(observeMemoryWarningNotification:) name:UIApplicationDidReceiveMemoryWarningNotification object:[UIApplication sharedApplication]];
    }
    return self;
}

- (void)setImage:(UIImage *)image forKey:(NSString *)key {
    if (image) { // we're setting up a new image
        self.imageDictionary[key] = image;
        NSString *imagePath = [self imagePathForKey:key];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        [imageData writeToFile:imagePath atomically:YES];
        
    } else { // nil was passed, indicating a desire to delete the image
        [self.imageDictionary removeObjectForKey:key];
        NSString *imagePath = [self imagePathForKey:key];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:imagePath error:nil];
    }
}

- (UIImage *)imageForKey:(NSString *)key {
    UIImage *image = self.imageDictionary[key];
    if (!image) {
        NSString *imagePath = [self imagePathForKey:key];
        image = [UIImage imageWithContentsOfFile:imagePath];
        if (image) {
            self.imageDictionary[key] = image;
        }
    }
    
    return image;
}

- (NSString *)imagePathForKey:(NSString *)key {
    NSArray *directories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directories firstObject];
    NSString *imagePath = [documentDirectory stringByAppendingPathComponent:key];
    return imagePath;
}

- (void)observeMemoryWarningNotification:(NSNotification *)note {
    // Clear the cache
    NSLog(@"flushing %ld images from the image store", (unsigned long)self.imageDictionary.count);
    [self.imageDictionary removeAllObjects];
}

@end
