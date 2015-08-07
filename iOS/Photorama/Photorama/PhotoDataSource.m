//
//  PhotoDataSource.m
//  Photorama
//
//  Created by Nikita Rau on 6/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "PhotoDataSource.h"
#import "PhotoCollectionViewCell.h"
#import "Photo.h"

@interface PhotoDataSource ()
@property(strong, nonatomic) NSManagedObjectContext *context;
@property(strong, nonatomic) UICollectionView *collectionView;
@end

@implementation PhotoDataSource

- (instancetype)initWithContext:(NSManagedObjectContext *)context collectionView:(UICollectionView *)collectionView {
    self = [super init];
    if (self) {
        _context = context;
        _collectionView = collectionView;
        _photos = [self sortedPhotosByDateInContext:_context];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self selector:@selector(contextChanged:) name:NSManagedObjectContextObjectsDidChangeNotification object:context];
    }
    return self;
}

- (void)dealloc {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

// MARK: Collection View Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photos.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PhotoCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    Photo *photo = self.photos[indexPath.row];
    [cell updateWithImage:photo.image];
    
    return cell;
}

- (NSArray *)sortedPhotosByDateInContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Photo"];
    
    NSSortDescriptor *dateDesc = [NSSortDescriptor sortDescriptorWithKey:@"dateTaken" ascending:NO];
    request.sortDescriptors = @[dateDesc];
    
    NSArray *fetchedPhotos = [context executeFetchRequest:request error:nil];
    return fetchedPhotos;
}

// MARK: Notifications
- (void)contextChanged:(NSNotification *)note {
    
    _photos = [self sortedPhotosByDateInContext:self.context];
    
    // Queue up a batch of updates to simultaneously hit the collection view
    [self.collectionView performBatchUpdates:^{
        // In this case, the userInfo dict is @{ NSString : NSSet }
        // where the keys are constant change type strings (inserted, deleted, updated, etc.)
        // and the values are NSSets of objects that have undergone the specified change type
        for (NSString *changeType in note.userInfo) {
            // One of the k/v pairs will contain the context, rather than a set
            // Let's ignore anything that's not an NSSet
            if (![note.userInfo[changeType] isKindOfClass:[NSSet class]]) {
                continue;
            }
            // For each of the changed Photos for a given change type...
            NSArray *changedPhotos = note.userInfo[changeType];
            for (Photo *changedPhoto in changedPhotos) {
                // ...look up its index in the self.photos array
                NSUInteger index = [self.photos indexOfObject:changedPhoto];
                if (index != NSNotFound) {
                    // if the Photo is indeed in self.photos...
                    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index
                                                                 inSection:0];
                    // ... update that photo's cell in the collection view
                    if (changeType == NSInsertedObjectsKey) {
                        [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
                    } else if (changeType == NSDeletedObjectsKey) {
                        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
                    } else if (changeType == NSUpdatedObjectsKey) {
                        [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
                    }
                }
            }
            
        }
    } completion:nil];
    
}

@end
