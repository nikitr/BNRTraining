//
//  Photo.m
//  Photorama
//
//  Created by Nikita Rau on 6/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "Photo.h"

@implementation Photo

@dynamic title;
@dynamic photoID;
@dynamic url;
@dynamic dateTaken;
@dynamic photoKey;
@dynamic tags;

@synthesize image;

- (NSString *)description {
    return [NSString stringWithFormat:@"<Photo id=\"%@\" title=\"%@\">", self.photoID, self.title];
}

- (void)awakeFromInsert {
    [super awakeFromInsert];
    
    // Perform necessary object setup
    self.photoKey = [[NSUUID UUID] UUIDString];
}

- (void)addTagObject:(NSManagedObject *)tag {
    NSMutableSet *currentTags = [self mutableSetValueForKey:@"tags"];
    [currentTags addObject:tag];
}
- (void)removeTagObject:(NSManagedObject *)tag {
    NSMutableSet *currentTags = [self mutableSetValueForKey:@"tags"];
    [currentTags removeObject:tag];
}

@end
