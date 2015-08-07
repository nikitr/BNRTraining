//
//  DrawView.h
//  TouchTracker
//
//  Created by Nikita Rau on 6/24/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"

@interface DrawView : UIView

@property (nonatomic) NSMutableDictionary *currentLines;
@property (nonatomic) NSMutableArray *finishedLines;
@property (nonatomic, weak) Line *selectedLine;
@property (nonatomic) UIPanGestureRecognizer *moveRecognizer;

@end
