//
//  main.m
//  Groceries
//
//  Created by Nikita Rau on 6/16/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        // Create 3 objects
        NSString *one = @"Loaf of bread";
        NSString *two = @"Container of milk";
        NSString *three = @"Stick of butter";
        
        // Create an empty NSMutableArray object
        NSMutableArray *groceryList = [NSMutableArray array];
        
        [groceryList addObject:one];
        [groceryList addObject:two];
        [groceryList addObject:three];
        
        // Print out grocery list
        printf("My grocery list is: ");
        for (NSString *s in groceryList) {
            NSLog(s);
        }
    }
    return 0;
}
