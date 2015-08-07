//
//  ColorViewController.h
//  ColorBoard
//
//  Created by Nikita Rau on 6/23/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ColorDescription;

@interface ColorViewController : UIViewController
@property (nonatomic, assign) BOOL existingColor;
@property (nonatomic, strong) ColorDescription *currentColorDescription;
@end
