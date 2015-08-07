//
//  PaletteViewController.m
//  ColorBoard
//
//  Created by Nikita Rau on 6/23/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "PaletteViewController.h"
#import "ColorDescription.h"
#import "ColorViewController.h"

@interface PaletteViewController ()

@end

@implementation PaletteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.colors = @[ [ColorDescription new] ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.colors.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell =
    [self.tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"
                                         forIndexPath:indexPath];
    cell.textLabel.text = [self.colors[indexPath.row] name];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *destVC = segue.destinationViewController;
    
    if ([segue.identifier isEqualToString:@"NewColor"]) {
        ColorDescription *newColorDescription = [ColorDescription new];
        self.colors = [self.colors arrayByAddingObject:newColorDescription];
        
        if ([destVC isKindOfClass:[UINavigationController class]]) {
            UINavigationController *nc = (UINavigationController *)destVC;
            ColorViewController *cvc = (ColorViewController *)nc.topViewController;
            cvc.currentColorDescription = newColorDescription;
            cvc.existingColor = NO;
        }
    } else if ([segue.identifier isEqualToString:@"ExistingColor"]) {
        NSInteger row = [self.tableView indexPathForSelectedRow].row;
        ColorDescription *colorDescription = self.colors[row];
        ColorViewController *cvc = (ColorViewController *)destVC;
        cvc.currentColorDescription = colorDescription;
        cvc.existingColor = YES;
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
