//
//  main.m
//  Stocks
//
//  Created by Nikita Rau on 6/16/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StockHolding.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // Create three instances of StockHolding
        StockHolding *one = [[StockHolding alloc] init];
        StockHolding *two = [[StockHolding alloc] init];
        StockHolding *three = [[StockHolding alloc] init];
        
        // Give the instance variables values using dot notation
        one.purchasePrice = 2.30;
        one.currentPrice = 4.50;
        one.numberOfShares = 40;
        
        two.purchasePrice = 12.19;
        two.currentPrice = 10.56;
        two.numberOfShares = 90;
        
        three.purchasePrice = 45.10;
        three.currentPrice = 49.51;
        three.numberOfShares = 210;
        
        // Add them to a mutable array
        NSMutableArray *stocks = [NSMutableArray array];
        [stocks addObject:one];
        [stocks addObject:two];
        [stocks addObject:three];
        
        // Print out elements of array
        for (StockHolding *s in stocks) {
            float value = s.valueInDollars;
            NSLog(@"stock value is: %f", value);
        }
    }
    return 0;
}
