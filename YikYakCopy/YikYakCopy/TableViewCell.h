//
//  TableViewCell.h
//  YikYakCopy
//
//  Created by Nikita Rau on 7/1/15.
//  Copyright (c) 2015 Nikita Rau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *yakText;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *replies;
@property (weak, nonatomic) IBOutlet UILabel *count;
- (void)awakeFromNib;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;

@end
