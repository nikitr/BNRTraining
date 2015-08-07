//
//  Line.h
//  TouchTracker
//
//  Created by Nikita Rau on 6/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Line : NSObject
@property (nonatomic) CGPoint begin;
@property (nonatomic) CGPoint end;
@property (nonatomic) NSArray *containingArray;

- (instancetype)initWithBegin:(CGPoint)begin end:(CGPoint)end;
@end

