//
//  ViewController.m
//  Photorama
//
//  Created by Nikita Rau on 6/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "PhotosViewController.h"
#import "PhotoStore.h"
#import "PhotoDataSource.h"
#import "Photo.h"
#import "PhotoCollectionViewCell.h"
#import "PhotoInfoViewController.h"
#import "CoreDataStack.h"

@interface PhotosViewController ()
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) PhotoDataSource *photoDataSource;
@end

@implementation PhotosViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.photoStore fetchRecentPhotosWithCompletion:^(NSArray *photos) {
        NSLog(@"Found %lu photos", (unsigned long)photos.count);
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.photoDataSource = [[PhotoDataSource alloc] initWithContext:self.photoStore.cdStack.mainQContext collectionView:self.collectionView];
    self.collectionView.dataSource = self.photoDataSource;
    self.collectionView.delegate = self;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Photo *photo = self.photoDataSource.photos[indexPath.row];
    // If there's already an image, bail - no need to redownload it
    if (photo.image != nil) {
        return;
    }
    
    // Download the image data, which could take some time
    [self.photoStore fetchImageForPhoto:photo completion:^(UIImage *image) {
        // When the request finishes, only update the cell fi it's still visible
        NSArray *visibleIndexPaths = [self.collectionView indexPathsForVisibleItems];
        if ([visibleIndexPaths containsObject:indexPath]) {
            [(PhotoCollectionViewCell *)cell updateWithImage:image];
        }
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showPhoto"]) {
        NSIndexPath *selectedIndexPath =
        [self.collectionView indexPathsForSelectedItems].firstObject;
        Photo *photo = self.photoDataSource.photos[selectedIndexPath.row];
        
        PhotoInfoViewController *destinationVC = segue.destinationViewController;
        destinationVC.photoStore = self.photoStore;
        destinationVC.photo = photo;
    }
}

@end
