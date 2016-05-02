//
//  PushView.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/24.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "PushView.h"
#import "SquareView.h"
#import "UIView+Addition.h"

@implementation PushView
{
    SquareView *square;
    UIDynamicAnimator *myAnimator;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        CGRect rect = [UIScreen mainScreen].bounds;
        
        square = [[SquareView alloc] init];
        square.center = CGPointMake(rect.size.width / 2, rect.size.height / 2);
        [self addSubview: square];
        
        myAnimator = [[UIDynamicAnimator alloc] initWithReferenceView: self];
        
        self.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pushPan = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handlePushGesture:)];
        [self addGestureRecognizer: pushPan];
    }
    return self;
}

- (void)handlePushGesture: (UIPanGestureRecognizer *)gesture {
    CGPoint velocity = [gesture velocityInView: self];
    CGPoint point = [gesture locationInView: self];
    if ((square.originX <= point.x) && (point.x <= square.rightX) && (square.originY <= point.y) && (point.y <= square.bottomY)) {
        UIPushBehavior *pushBehavior = [[UIPushBehavior alloc] initWithItems: @[square] mode: UIPushBehaviorModeInstantaneous];
        pushBehavior.pushDirection = CGVectorMake(velocity.x / 1000, velocity.y / 1000);
        [myAnimator addBehavior: pushBehavior];
    }
}

@end
