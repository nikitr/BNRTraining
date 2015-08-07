//
//  Item.h
//  RandomItems
//
//  Created by Nikita Rau on 6/18/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

// Declare a class using @interface ClassName : SuperclassName
@interface Item : NSObject

@property (nonatomic, strong) Item *containedItem;
@property (nonatomic, weak) Item *container;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *serialNumber;
@property (nonatomic) int valueInDollars;
@property (nonatomic, readonly, strong) NSDate *dateCreated;

// Instance variables, Class Methods, Initializers, Other Instance Methods
// Class Methods: +
+ (instancetype)randomItem;

- (instancetype)initWithName:(NSString *)name
    valueInDollars:(int)value
        serialNumber:(NSString *)sNumber;

- (instancetype)initWithName:(NSString *)name;

@end
