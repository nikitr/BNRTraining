//
//  CoreDataStack.h
//  Photorama
//
//  Created by Nikita Rau on 6/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface CoreDataStack : NSObject

@property(strong, nonatomic) NSManagedObjectContext *mainQContext;

- (instancetype)initWithModelName:(NSString *)modelName NS_DESIGNATED_INITIALIZER;
- (BOOL)saveChanges:(NSError **)error;

@end
