//
//  BlockView.m
//  Blocker2
//
//  Created by Shahn Auronas on 12/2/13.
//  Copyright (c) 2013 Shahn Auronas. All rights reserved.
//

#import "BlockView.h"


@implementation BlockView

@synthesize color;

- (id)initWithFrame:(CGRect)frame color:(int)inputColor;
{
    self = [super initWithFrame:frame];
    if (self) {
        self.color = inputColor;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    float viewWidth, viewHeight;
    viewWidth = self.bounds.size.width;
    viewHeight = self.bounds.size.height;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect blockRect = CGRectMake(0, 0, viewWidth, viewHeight);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:blockRect];
    path.lineWidth = 2.0;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef myGradient;
    
    int numberOfLocations = 2;
    CGFloat locations[2] = {0.0, 1.0};
    CGFloat components[8] = {0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 1.0, 1.0};
    
    switch (self.color) {
        case RED_COLOR:
            components[0] = 1.0;
            break;
        case GREEN_COLOR:
            components[1] = 1.0;
            break;
        case BLUE_COLOR:
            components[2] = 1.0;
            break;
        default:
            break;
    }
    
    myGradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, numberOfLocations);
    
    CGContextDrawLinearGradient(context, myGradient, CGPointMake(0,0), CGPointMake(viewWidth, 0), 0);
    
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(myGradient);
    
    [path stroke];
}


@end
