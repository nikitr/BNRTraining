//
//  Person.h
//  BMITime
//
//  Created by Nikita Rau on 6/16/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

// Person has two properties
@property (nonatomic) float heightInMeters;
@property (nonatomic) int weightInKilos;


// Person has a method that calculates the Body Mass Index
- (float)bodyMassIndex;

@end
