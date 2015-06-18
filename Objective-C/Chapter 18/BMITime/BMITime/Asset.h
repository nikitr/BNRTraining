//
//  Asset.h
//  BMITime
//
//  Created by Nikita Rau on 6/17/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Employee;

@interface Asset : NSObject
@property (nonatomic, copy) NSString *label;
@property (nonatomic, weak) Employee *holder;
@property (nonatomic) unsigned int resaleValue;

@end
