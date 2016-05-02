//
//  GravityView.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/22.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "GravityView.h"
#import "BallView.h"

@implementation GravityView
{
    UIDynamicAnimator *myAnimator;
    NSMutableArray *ballsArray;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        ballsArray = [@[] mutableCopy];
        
        NSArray *operationName = @[@"向下", @"向左", @"倾斜", @"向上"];
        for (NSInteger i = 0; i < 4; i++) {
            UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
            button.frame = CGRectMake(10 + i * 100, 80, 60, 30);
            button.backgroundColor = [UIColor lightGrayColor];
            button.tag = i;
            [button setTitle: operationName[i] forState: UIControlStateNormal];
            [button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
            [button addTarget: self action: @selector(gravityAnimator:) forControlEvents: UIControlEventTouchUpInside];
            [self addSubview: button];
            
            BallView *ball = [[BallView alloc] init];
            ball.center = CGPointMake(40 + i * 100, 150);
            [self addSubview: ball];
            [ballsArray addObject: ball];
        }
    }
    return self;
}

- (void)gravityAnimator: (id)sender {
    UIButton *button = (UIButton *)sender;
    BallView *ball = (BallView *)[ballsArray objectAtIndex: button.tag];
    
    myAnimator = [[UIDynamicAnimator alloc] initWithReferenceView: self];
    myAnimator.delegate = self;
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems: @[ball]];
    
    // When running, the dynamic animator calls the action block on every animation step.
    gravityBehavior.action = ^{
    };

    switch (button.tag) {
        case 0:
        {
            break;
        }
        
        case 1:
        {
            gravityBehavior.gravityDirection = CGVectorMake(1.0, 0.0);
            break;
        }
        
        case 2:
        {
            gravityBehavior.angle = M_PI_2 / 3;
            break;
        }
        
        case 3:
        {
            gravityBehavior.gravityDirection = CGVectorMake(0, - 1);
            break;
        }
            
        default:
            break;
    }
    
    [myAnimator addBehavior: gravityBehavior];
}

#pragma mark - UIDynamicAnimatorDelegate

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
