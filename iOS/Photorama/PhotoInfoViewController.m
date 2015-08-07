//
//  PhotoInfoViewController.m
//  Photorama
//
//  Created by Nikita Rau on 6/25/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "PhotoInfoViewController.h"
#import "Photo.h"
#import "PhotoStore.h"
#import "TagsViewController.h"

@interface PhotoInfoViewController ()

@end

@implementation PhotoInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.photoStore fetchImageForPhoto:self.photo completion:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.navigationItem.title = self.photo.title;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showTags"]) {
        UINavigationController *navCon = segue.destinationViewController;
        TagsViewController *tvc = (TagsViewController *)navCon.topViewController;
        
        tvc.photoStore = self.photoStore;
        tvc.photo = self.photo;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
