//
//  StockHolding.m
//  Stocks
//
//  Created by Nikita Rau on 6/16/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "StockHolding.h"

@implementation StockHolding

- (float)costInDollars
{
    return [self purchasePrice] * [self numberOfShares];
}

- (float)valueInDollars
{
    return [self currentPrice] * [self numberOfShares];
}

@end
