//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Nikita Rau on 6/18/15.
//  Copyright (c) 2015 Big Nerd Ranch. All rights reserved.
//

#import "HypnosisView.h"

@interface HypnosisView ()
@property (nonatomic, assign) CGFloat radiusOffset;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HypnosisView

//- (void)didMoveToSuperview {
//    if (self.superview != nil) {
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0/30.0
//                                                       target:self
//                                                     selector:@selector(timerFired:)
//                                                     userInfo:nil
//                                                      repeats:YES];
//    }
//}

- (void)removeFromSuperview {
    [self.timer invalidate];
    self.timer = nil;
    [super removeFromSuperview];
}

- (void)timerFired:(NSTimer *)timer {
    NSLog(@"pew");
    
    // Increment the radius offset
    self.radiusOffset += 1.0;
    
    // Reset the radius offset once it reaches 20, to create a looping effect
    if (self.radiusOffset > 20.0) {
        self.radiusOffset = 0;
    }
}

- (void)setRadiusOffset:(CGFloat)radiusOffset {
    _radiusOffset = radiusOffset;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGRect bounds = self.bounds;
    
    // Figure out the center of the bounds rectangle
    CGFloat centerX = bounds.origin.x + bounds.size.width / 2.0;
    CGFloat centerY = bounds.origin.y + bounds.size.height / 2.0;
    CGPoint center = CGPointMake(centerX, centerY);
    
    // The largest circle will inscribe the view
    CGFloat maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    // Starting with a circle of radius 0, draw larger and larger
    // concentric circles until you've reached the maxRadius
    for (CGFloat radius = 0.0; radius < maxRadius; radius += 20) {
        UIBezierPath *path = [[UIBezierPath alloc] init];
        // Add an arc to the path at center, with our calculated radius,
        // from 0 to 2pi radians (a circle)
        [path addArcWithCenter:center radius:radius startAngle:0.0 endAngle:M_PI * 2.0 clockwise:YES];
        
        // Set the line width to 10 pts
        path.lineWidth = 10;
        
        // Make the line purple
        // and make it less opaque the larger its radius
        CGFloat alpha = ((radius + self.radiusOffset - 10.0) / maxRadius);
        [[[UIColor purpleColor] colorWithAlphaComponent:alpha] setStroke];
        
        // Draw the line
        [path stroke];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


@end
