//
//  ViewController.m
//
//  Created by Nick Lockwood on 03/02/2013.
//  Copyright (c) 2013 Charcoal Design. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@property (nonatomic, weak) IBOutlet UIView *layerView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //create timing function
    CAMediaTimingFunction *function =
        [CAMediaTimingFunction functionWithName:
         kCAMediaTimingFunctionEaseInEaseOut];
    
    //get control points
    float cp1[2], cp2[2];
    [function getControlPointAtIndex:1 values:cp1];
    [function getControlPointAtIndex:2 values:cp2];
    CGPoint controlPoint1 = CGPointMake(cp1[0], cp1[1]);
    CGPoint controlPoint2 = CGPointMake(cp2[0], cp2[1]);
    
    //create curve
    UIBezierPath *path = [[UIBezierPath alloc] init];
    [path moveToPoint:CGPointZero];
    [path addCurveToPoint:CGPointMake(1, 1)
            controlPoint1:controlPoint1
            controlPoint2:controlPoint2];
    
    //scale the path up to a reasonable size for display
    [path applyTransform:CGAffineTransformMakeScale(200, 200)];
    
    //create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = [UIColor redColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 4.0f;
    shapeLayer.path = path.CGPath;
    [self.layerView.layer addSublayer:shapeLayer];
    
    //flip geometry so that 0,0 is in the bottom-left
    self.layerView.layer.geometryFlipped = YES;
}

@end
