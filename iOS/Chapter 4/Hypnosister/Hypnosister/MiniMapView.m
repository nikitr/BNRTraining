//
//  MiniMapView.m
//  Hypnosister
//
//  Created by Nikita Rau on 6/19/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "MiniMapView.h"

@interface MiniMapView ()
@property (nonatomic) CGFloat relativeX;
@property (nonatomic) CGFloat relativeY;
@property (nonatomic) CGFloat relativeWidth;
@property (nonatomic) CGFloat relativeHeight;
@end

@implementation MiniMapView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
    }
    return self;
}

// MARK: - Accessors
- (void)setRelativeX:(CGFloat)relativeX {
    _relativeX = relativeX;
    [self setNeedsDisplay];
}

- (void)setRelativeY:(CGFloat)relativeY {
    _relativeY = relativeY;
    [self setNeedsDisplay];
}

- (void)setRelativeWidth:(CGFloat)relativeWidth {
    _relativeWidth = relativeWidth;
    [self setNeedsDisplay];
}

- (void)setRelativeHeight:(CGFloat)relativeHeight {
    _relativeHeight = relativeHeight;
    [self setNeedsDisplay];
}

- (void) drawRect:(CGRect)rect {
    CGSize boundsSize = self.bounds.size;
    
    // Compute the sub-rectangle that represents the current view area in the scrollview
    CGFloat x = boundsSize.width * self.relativeX;
    CGFloat y =  boundsSize.height * self.relativeY;
    CGFloat width = boundsSize.width * self.relativeWidth;
    CGFloat height = boundsSize.height * self.relativeHeight;
    
    // Create the path around that sub-rectangle
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointMake(x, y)];
    [path addLineToPoint:CGPointMake(x+width, y)];
    [path addLineToPoint:CGPointMake(x+width, y+height)];
    [path addLineToPoint:CGPointMake(x, y+height)];
    [path closePath];
    
    // Fill it with a semi-transparent gray (which will overlay the background lgiht gray
    [[[UIColor grayColor] colorWithAlphaComponent:0.8] setFill];
    [path fill];
}

- (void)updateWithScrollView:(UIScrollView *)sv {
    self.relativeX = sv.contentOffset.x / sv.contentSize.width;
    self.relativeY = sv.contentOffset.y / sv.contentSize.height;
    self.relativeWidth = sv.bounds.size.width / sv.contentSize.width;
    self.relativeHeight = sv.bounds.size.height / sv.contentSize.height;
}

@end
