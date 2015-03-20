//
//  HypnosisView.m
//  Hypnosister
//
//  Created by Gabriel Oliva de Oliveira on 3/19/15.
//  Copyright (c) 2015 Gabriel Oliva de Oliveira. All rights reserved.
//

#import "HypnosisView.h"

@import CoreGraphics;

@interface HypnosisView ()

@property (strong, nonatomic) UIColor *circleColor;

@end

@implementation HypnosisView

- (void)setCircleColor:(UIColor *)circleColor
{
    _circleColor = circleColor;
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect bounds = self.bounds;
    // Figure out the center of the bounds rectangle
    
    CGPoint center;
    center.x = bounds.origin.x + bounds.size.width / 2.0;
    center.y = bounds.origin.y + bounds.size.height / 2.0;
    
    // The circle will be the largest that will fit in the view
    //float radius = (MIN(bounds.size.width, bounds.size.height) / 2.0);
    
    // The largest circle will circumscribe the view
    float maxRadius = hypot(bounds.size.width, bounds.size.height) / 2.0;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // Add an arc to the path at center, with radius of radius,
    // from 0 to 2*PI radians (a circle)
    //[path addArcWithCenter:center
    //                radius:radius
    //            startAngle:0.0
    //              endAngle:M_PI * 2.0
    //             clockwise:YES];
    
    for (float currentRadius = maxRadius; currentRadius > 0; currentRadius -= 20) {
        
        [path moveToPoint:CGPointMake(center.x + currentRadius, center.y)];
        
        [path addArcWithCenter:center
                        radius:currentRadius // Note this is currentRadius!
                    startAngle:0.0
                      endAngle:M_PI * 2.0
                     clockwise:YES];
    }
    
    // Configure line width to 10 points
    path.lineWidth = 10;
    
    // Configure the drawing color to light gray
    //[[UIColor lightGrayColor] setStroke];
    [self.circleColor setStroke];
    
    // Draw the line!
    [path stroke];
    
    /*CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    
    // Create a triangle path
    UIBezierPath *trianglePath = [[UIBezierPath alloc] init];
    [trianglePath moveToPoint:CGPointMake(bounds.size.width / 2.0, self.bounds.size.height/5)];
    [trianglePath addLineToPoint:CGPointMake(50.0, bounds.size.height - self.bounds.size.height/5)];
    [trianglePath addLineToPoint:CGPointMake(bounds.size.width - 50.0, bounds.size.height - self.bounds.size.height/5)];
    [trianglePath addLineToPoint:CGPointMake(bounds.size.width / 2.0, self.bounds.size.height/5)];
    
    // Draw the path -- not required for the challenge but I wanted the outline of it
    [trianglePath stroke];
    
    // Clip the drawing area to just the defined triangle
    [trianglePath addClip];
    
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = { 0.0, 1.0, 0.0, 1.0,   // Start color is red
        1.0, 1.0, 0.0, 1.0 }; // End color is yellow
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, 2);
    
    CGPoint startPoint;
    startPoint.x = 0.0;
    startPoint.y = self.bounds.size.height/5;
    
    CGPoint endPoint;
    endPoint.x = 0.0;
    endPoint.y = bounds.size.height - self.bounds.size.height/5;
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorspace);
    
    CGContextRestoreGState(context);
    
    context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetShadow(context, CGSizeMake(4,7), 3);
    
    UIImage *logoImage = [UIImage imageNamed:@"logo.png"];
    
    CGRect someRect = CGRectMake(self.bounds.size.width/4, self.bounds.size.height/4, self.bounds.size.width/2, self.bounds.size.height/2);
    [logoImage drawInRect:someRect];
    
    CGContextRestoreGState(context);
    
    //context = UIGraphicsGetCurrentContext();
    //CGContextSaveGState(context);
    
    //CGContextRestoreGState(context);*/

}
    
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // All BNRHypnosisViews start with a clear background color
        self.backgroundColor = [UIColor clearColor];
        self.circleColor = [UIColor lightGrayColor];
    }
    return self;
}

// When a finger touches the screen
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ was touched", self);
    // Get 3 random numbers between 0 and 1
    float red = (arc4random() % 100) / 100.0;
    float green = (arc4random() % 100) / 100.0;
    float blue = (arc4random() % 100) / 100.0;
    UIColor *randomColor = [UIColor colorWithRed:red
                                           green:green
                                            blue:blue
                                           alpha:1.0];
    self.circleColor = randomColor;
}



@end
