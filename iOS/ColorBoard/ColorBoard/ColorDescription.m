//
//  ColorDescription.m
//  ColorBoard
//
//  Created by Nikita Rau on 6/23/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "ColorDescription.h"

@implementation ColorDescription
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.name = @"Blue";
        self.color = [UIColor blueColor];
    }
    return self;
}
@end
