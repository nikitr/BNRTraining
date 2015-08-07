//
//  ColorDescription.h
//  ColorBoard
//
//  Created by Nikita Rau on 6/23/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ColorDescription : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UIColor *color;
@end
