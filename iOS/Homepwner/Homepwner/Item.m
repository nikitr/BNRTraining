//
//  Item.m
//  RandomItems
//
//  Created by Nikita Rau on 1/12/14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "Item.h"

@interface Item ()
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;
@end

@implementation Item

+ (instancetype)randomItem {
  // Create an immutable array of three adjectives
  NSArray *randomAdjectiveList = @[@"Fluffy", @"Rusty", @"Shiny"];
  
  // Create an immutable array of three nouns
  NSArray *randomNounList = @[@"Bear", @"Spork", @"Mac"];
  
  // Get the index of a random adjective/noun from the lists
  // Note: The % operator, called the modulo operator, gives
  // you the remainder. So adjectiveIndex is a random number
  // from 0 to 2 inclusive.
  NSInteger adjectiveIndex = arc4random() % [randomAdjectiveList count];
  NSInteger nounIndex = arc4random() % [randomNounList count];
  
  // Note that NSInteger is not an object, but a type definition
  // for "long"
  
  NSString *randomName = [NSString stringWithFormat:@"%@ %@",
                          randomAdjectiveList[adjectiveIndex],
                          randomNounList[nounIndex]];
  
  int randomValue = arc4random() % 100;
  
  NSString *randomSerialNumber = [NSString stringWithFormat:@"%c%c%c%c%c",
                                  '0' + arc4random() % 10,
                                  'A' + arc4random() % 26,
                                  '0' + arc4random() % 10,
                                  'A' + arc4random() % 26,
                                  '0' + arc4random() % 10];
  
  Item *newItem = [[self alloc] initWithItemName:randomName
                                  valueInDollars:randomValue
                                    serialNumber:randomSerialNumber];
  
  return newItem;
}

- (instancetype)initWithItemName:(NSString *)name
                  valueInDollars:(int)value
                    serialNumber:(NSString *)sNumber {
  if (self = [super init]) {
    // Give the instance variables initial values
    _itemName = name;
    _serialNumber = sNumber;
    _valueInDollars = value;
    _dateCreated = [[NSDate alloc] init];
    _itemKey = [[NSUUID UUID] UUIDString];
  }
  
  // Return the address of the newly initialized object
  return self;
}

- (instancetype)initWithItemName:(NSString *)name {
  return [self initWithItemName:name
                 valueInDollars:0
                   serialNumber:@""];
}

- (instancetype)init {
  return [self initWithItemName:@"Item"];
}

- (void)dealloc {
  NSLog(@"Destroyed: %@", self);
}

- (void)setContainedItem:(Item *)containedItem {
  _containedItem = containedItem;
  self.containedItem.container = self;
}

- (NSString *)description {
  NSString *descriptionString =
  [[NSString alloc] initWithFormat:@"%@ (%@): Worth $%d, recorded on %@",
   self.itemName,
   self.serialNumber,
   self.valueInDollars,
   self.dateCreated];
  return descriptionString;
}

// MARK: - NSCoding

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.itemName forKey:@"itemName"];
  [aCoder encodeObject:self.dateCreated forKey:@"dateCreated"];
  [aCoder encodeObject:self.itemKey forKey:@"itemKey"];
  [aCoder encodeObject:self.serialNumber forKey:@"serialNumber"];
  [aCoder encodeInt:self.valueInDollars forKey:@"valueInDollars"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if (self = [super init]) {
    _itemName = [aDecoder decodeObjectForKey:@"itemName"];
    _dateCreated = [aDecoder decodeObjectForKey:@"dateCreated"];
    _itemKey = [aDecoder decodeObjectForKey:@"itemKey"];
    _serialNumber = [aDecoder decodeObjectForKey:@"serialNumber"];
    _valueInDollars = [aDecoder decodeIntForKey:@"valueInDollars"];
  }
  return self;
}

@end
