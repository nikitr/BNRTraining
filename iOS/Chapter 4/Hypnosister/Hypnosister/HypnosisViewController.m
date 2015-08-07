//
//  HypnosisViewController.m
//  Hypnosister
//
//  Created by Nikita Rau on 6/19/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "HypnosisViewController.h"
#import "HypnosisView.h"

@interface HypnosisViewController ()
@property (nonatomic, weak) UILabel *textLabel;
@end

@implementation HypnosisViewController

- (void)loadView {
    // Create a view
    CGRect frame = [[UIScreen mainScreen] bounds];
    HypnosisView *backgroundView = [[HypnosisView alloc] initWithFrame:frame];
    
    // Set it as *the* view of this view controller
    self.view = backgroundView;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    label.center = self.view.center;
    label.font = [UIFont systemFontOfSize:24];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Achieve\nNerdvana";
    label.numberOfLines = 2;
    [self.view addSubview:label];
    self.textLabel = label;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.tabBarItem.title = @"Hypnotize";
        self.tabBarItem.image = [UIImage imageNamed:@"Hypno.png"];
    }
    return self;
}

- (void)viewDidLoad {
    // Always call the super implementation of viewDidLoad
    [super viewDidLoad];
    
    NSLog(@"HypnosisViewController loaded its view!");
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set the label's initial alpha
    self.textLabel.alpha = 0.0;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // Set up the keyframe animation
    [UIView animateKeyframesWithDuration:2.0 delay:0.0 options:0 animations:^{
        // Animate the alpha over the entire animation duration
        self.textLabel.alpha = 1;
        
        // Add a keyframe
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.4 animations:^{
         self.textLabel.transform = CGAffineTransformMakeScale(0.5, 2.0);
         }];
        // Usually each will start where the previous one ends
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.3 animations:^{
            self.textLabel.transform = CGAffineTransformMakeScale(2.0, 0.5);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
            self.textLabel.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }
                              completion:^(BOOL finished) {
                                  NSLog(@"Keyframe animation completed!");
                              }];

}

@end
