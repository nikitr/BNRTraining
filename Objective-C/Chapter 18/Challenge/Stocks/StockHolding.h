//
//  StockHolding.h
//  Stocks
//
//  Created by Nikita Rau on 6/16/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StockHolding : NSObject

// StockHolding has three properties - this takes care of getter and setter
@property (nonatomic) float purchasePrice;
@property (nonatomic) float currentPrice;
@property (nonatomic) int numberOfShares;


// StockHolding has two methods
- (float)costInDollars;
- (float)valueInDollars;



@end
