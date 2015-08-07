//
//  Item.m
//  RandomItems
//
//  Created by Nikita Rau on 6/18/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "Item.h"

@implementation Item

+ (instancetype)randomItem
{
    // Create an immutable array of three adjectives
    NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
    
    // Create an immutable array of three nouns
    NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
    
    // Get the index of a random adj/noun from the lists
    unsigned int adjectiveIndex =
    arc4random_uniform((unsigned int)[randomAdjectiveList count]);
    unsigned int nounIndex =
    arc4random_uniform((unsigned int)[randomNounList count]);
    
    // Note that NSInteger is not an object, but a type definition for "long"
    NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                            [randomAdjectiveList objectAtIndex:adjectiveIndex],
                            [randomNounList objectAtIndex:nounIndex]];
    
    // Generate the random value in dollars, 0-99
    int randomValue = arc4random_uniform(100);
    
    // Use NSUUID to generate a random 5-letter string for the serial number
    NSString *randomSerialNumber = [[[NSUUID UUID] UUIDString] substringToIndex:5];
    
    // Instantiate the new item with the random values
    Item *newItem = [[self alloc] initWithName:randomName
                     valueInDollars:randomValue
                                  serialNumber:randomSerialNumber];
    
    return newItem;
}

- (instancetype)initWithName:(NSString *)name
              valueInDollars:(int)value
                serialNumber:(NSString *)sNumber
{
    // Call the superclass's designated initializer
    self = [super init];
    
    // Did the superclass's designated initializer succeed?
    if (self) {
        // Give the instance variables initial values
        _name = name;
        _serialNumber = sNumber;
        _valueInDollars = value;
        // Set _dateCreated to the current date and time
        _dateCreated = [[NSDate alloc] init];
    }
    // Return the address of the newly initialized object
    return self;
}

- (instancetype)initWithName:(NSString *)name
{
    return [self initWithName:name
               valueInDollars:0 serialNumber:@""""];
}

- (instancetype)init{
    return [self initWithName:@"Item"];
}

- (NSString *)description
{
    NSString *descriptionString =
    [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
     self.name,
     self.serialNumber,
     self.valueInDollars,
     self.dateCreated];
    
    return descriptionString;
}

- (void)dealloc
{
    NSLog(@"Destroyed: %@", self);
}

- (void)setContainedItem:(Item *)containedItem
{
    _containedItem = containedItem;
    self.containedItem.container = self;
}

@end
