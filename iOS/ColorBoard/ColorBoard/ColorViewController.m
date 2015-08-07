//
//  ColorViewController.m
//  ColorBoard
//
//  Created by Nikita Rau on 6/23/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "ColorViewController.h"
#import "ColorDescription.h"

@interface ColorViewController ()
@property (weak, nonatomic) IBOutlet UISlider *redSlider;
@property (weak, nonatomic) IBOutlet UISlider *greenSlider;
@property (weak, nonatomic) IBOutlet UISlider *blueSlider;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ColorViewController

- (IBAction)changeColor:(id)sender {
    CGFloat red = self.redSlider.value;
    CGFloat green = self.greenSlider.value;
    CGFloat blue = self.blueSlider.value;
    UIColor *newColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    self.view.backgroundColor = newColor;
}

- (IBAction)dismiss:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIColor *color = self.currentColorDescription.color;
    
    // Get the RGB values out of the UIColor object by reference
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:nil];
    
    // Set the initial slider values
    self.redSlider.value = red;
    self.greenSlider.value = green;
    self.blueSlider.value = blue;
    
    // Set the background color and text field value
    self.view.backgroundColor = color;
    self.textField.text = self.currentColorDescription.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Remove the 'Done' button if this is an existing color
    if (self.existingColor) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Give a default name and color in case the view's background color is nil
    NSString *rgbName = [NSString stringWithFormat:@"RGB %.0f %.0f %.0f",
                         self.redSlider.value * 255.0,
                         self.greenSlider.value * 255.0,
                         self.blueSlider.value * 255.0];
    if (self.textField.text.length == 0) {
        self.currentColorDescription.name = rgbName;
    } else {
        self.currentColorDescription.name = self.textField.text;
    }
    
    self.currentColorDescription.color =
    self.view.backgroundColor ?: [UIColor whiteColor];
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
