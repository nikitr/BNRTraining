//
//  PhotoDataSource.h
//  Photorama
//
//  Created by Nikita Rau on 6/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface PhotoDataSource : NSObject <UICollectionViewDataSource>

@property(strong, readonly, nonatomic) NSArray *photos;

- (instancetype)initWithContext:(NSManagedObjectContext *)context
                 collectionView:(UICollectionView *)collectionView NS_DESIGNATED_INITIALIZER;

@end
