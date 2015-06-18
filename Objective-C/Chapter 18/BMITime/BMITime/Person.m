//
//  Person.m
//  BMITime
//
//  Created by Nikita Rau on 6/16/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "Person.h"

@implementation Person

- (float)bodyMassIndex
{
    float h = [self heightInMeters];
    return [self weightInKilos] / (h * h);
}

@end
