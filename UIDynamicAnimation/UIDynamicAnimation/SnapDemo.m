//
//  SnapDemo.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/5/1.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "SnapDemo.h"
#import "BallView.h"
#import "UIView+Addition.h"
#import "ColorUtils.h"

@implementation SnapDemo
{
    UIView *centerView;
    UIDynamicAnimator *myAnimator;
    NSInteger ballCount;
    UIButton *button;
    UIColor *centerColor;
    UIColor *resultColor;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        CGRect rect = [UIScreen mainScreen].bounds;
        ballCount = 0;
        centerColor = [UIColor colorWithRed:1.000 green:0.600 blue:0.000 alpha:1.000];
        
        centerView = [[UIView alloc] init];
        centerView.bounds = CGRectMake(0, 0, 40, 40);
        centerView.center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
        centerView.backgroundColor = centerColor;
        centerView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        [self addSubview: centerView];
        
        button = [UIButton buttonWithType: UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 100, 30);
        button.center = CGPointMake(rect.size.width / 2, rect.size.height - 50);
        button.backgroundColor = [UIColor whiteColor];
        button.layer.borderColor = [UIColor grayColor].CGColor;
        button.layer.borderWidth = 1;
        [button setTitle: @"start" forState: UIControlStateNormal];
        [button setTitleColor: [UIColor grayColor] forState: UIControlStateNormal];
        [button addTarget: self action: @selector(addDynamicBehavior) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: button];
        
    }
    return self;
}

- (void)addDynamicBehavior {
    button.enabled = NO;
    button.backgroundColor = [UIColor grayColor];
    [button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];

    UIColor *ballColor;
    BallView *ballView = [[BallView alloc] init];
    ballView.center = CGPointMake(60, 120);
    switch (ballCount) {
        case 0:
        {
            ballColor = [UIColor colorWithRed:0.000 green:1.000 blue:0.600 alpha:1.000];
            ballView.backgroundColor = ballColor;
            break;
        }
            
        case 1:
        {
            ballColor = [UIColor colorWithRed:0.200 green:0.800 blue:1.000 alpha:1.000];
            ballView.backgroundColor = ballColor;
            break;
        }
            
        case 2:
        {
            ballColor = [UIColor colorWithRed:1.000 green:0.400 blue:0.400 alpha:1.000];
            ballView.backgroundColor = ballColor;
            break;
        }
            
        case 3:
        {
            ballColor = [UIColor colorWithRed:0.200 green:0.400 blue:1.000 alpha:1.000];
            ballView.backgroundColor = ballColor;
            break;
        }
            
        default:
            break;
    }
    resultColor = [ColorUtils colorOverlayWithBasicColor: centerColor mixColor: ballColor];
    [self addSubview: ballView];
    
    myAnimator = [[UIDynamicAnimator alloc] initWithReferenceView: self];
    myAnimator.delegate = self;
    
    CGFloat offsetX = ballCount % 2 == 0? 0 : centerView.width;
    CGFloat offsetY = ballCount - 2 >= 0? centerView.height : 0;
    NSLog(@"offsetX = %lf & offsetY = %lf", offsetX, offsetY);
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems: @[ballView]];
    gravityBehavior.action = ^{
        if (ballView.originY >= ([UIScreen mainScreen].bounds.size.height - 160)) {
            UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem: ballView snapToPoint: CGPointMake(centerView.originX + offsetX, centerView.originY + offsetY)];
            snapBehavior.damping = 0.3;
            [myAnimator addBehavior: snapBehavior];
        }
    };
    [myAnimator addBehavior: gravityBehavior];
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    [animator removeAllBehaviors];
    ballCount++;
    centerColor = resultColor;
    centerView.backgroundColor = resultColor;
    if (ballCount >= 4) {
        return;
    }
    button.enabled = YES;
    button.backgroundColor = [UIColor whiteColor];
    [button setTitleColor: [UIColor grayColor] forState: UIControlStateNormal];
}

@end
