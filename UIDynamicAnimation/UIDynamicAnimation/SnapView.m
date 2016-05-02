//
//  SnapView.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/24.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "SnapView.h"
#import "BallView.h"
#import "ColorUtils.h"

@implementation SnapView
{
    BallView *centerBall;
    UIDynamicAnimator *myAnimator;
    NSMutableArray *ballsArray;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        CGRect rect = [UIScreen mainScreen].bounds;
        
        ballsArray = [@[] mutableCopy];
        
        centerBall = [[BallView alloc] init];
        centerBall.center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
        centerBall.backgroundColor = [UIColor whiteColor];
        [self addSubview: centerBall];
        [ballsArray addObject: centerBall];
        
        UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 100, 30);
        button.center = CGPointMake(centerBall.center.x, rect.size.height - 50);
        button.backgroundColor = [UIColor lightGrayColor];
        [button setTitle: @"start" forState: UIControlStateNormal];
        [button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
        [button addTarget: self action: @selector(addDynamicBehavior:) forControlEvents: UIControlEventTouchUpInside];
        [self addSubview: button];
    }
    return self;
}

- (void)addDynamicBehavior: (id)sender {
    BallView *ballView = [[BallView alloc] init];
    ballView.center = CGPointMake(50, 100);
    ballView.backgroundColor = [ColorUtils randomColor];
    [self addSubview: ballView];
    [ballsArray addObject: ballView];
    
    myAnimator = [[UIDynamicAnimator alloc] initWithReferenceView: self];
    myAnimator.delegate = self;
    
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems: @[ballView]];
    [myAnimator addBehavior: gravityBehavior];
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems: ballsArray];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    [myAnimator addBehavior: collisionBehavior];
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem: ballView snapToPoint: centerBall.center];
    snapBehavior.damping = 0.4;
    [myAnimator addBehavior: snapBehavior];
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    [animator removeAllBehaviors];
}

@end
