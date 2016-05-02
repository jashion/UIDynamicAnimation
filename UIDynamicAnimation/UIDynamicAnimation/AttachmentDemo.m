//
//  AttachmentDemo.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/24.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "AttachmentDemo.h"
#import "BallView.h"
#import "UIView+Addition.h"
#import "ColorUtils.h"

#define kScreen [UIScreen mainScreen].bounds

@implementation AttachmentDemo
{
    NSMutableArray *ballsArray;
    NSMutableArray *topSquares;
    UIDynamicAnimator *myAnimator;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        ballsArray = [@[] mutableCopy];
        
        for (NSInteger i = 0; i < 5; i++) {
            BallView *ball = [[BallView alloc] init];
            ball.center = CGPointMake(kScreen.size.width / 2 + (i - 2) * ball.width, kScreen.size.height / 2);
            [self addSubview: ball];
            [ballsArray addObject: ball];
            
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handlePanGesture:)];
            [ball addGestureRecognizer: pan];
            [ball addObserver: self forKeyPath: @"center" options: NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context: nil];
            
            UIView *square = [[UIView alloc] init];
            square.bounds = CGRectMake(0, 0, 20, 20);
            square.center = CGPointMake(ball.centerX, ball.centerY - 200);
            square.backgroundColor = [UIColor colorWithRed:0.400 green:0.600 blue:0.000 alpha:1.000];
            [self addSubview: square];
            [topSquares addObject: square];
        }
        
        [self addDynamicBehavior];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [[UIColor colorWithRed:0.400 green:0.600 blue:0.000 alpha:1.000] setFill];
    
    for (NSInteger i = 0; i < 5; i++) {
        BallView *ball = (BallView *)ballsArray[i];
        CGContextSaveGState(context);
        CGContextMoveToPoint(context, kScreen.size.width / 2 + (i - 2) * 40, kScreen.size.height / 2 - 200);
        CGContextAddLineToPoint(context, ball.centerX, ball.centerY);
        CGContextStrokePath(context);
        CGContextRestoreGState(context);
    }
}

- (void)dealloc {
    for (BallView *ball in ballsArray) {
        [ball removeObserver: self forKeyPath: @"center"];
    }
}

- (void)handlePanGesture: (UIPanGestureRecognizer *)gesture {
    UIPushBehavior *push;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            push = [[UIPushBehavior alloc] initWithItems: @[ballsArray[0]] mode: UIPushBehaviorModeInstantaneous];
            push.pushDirection = CGVectorMake(- [gesture locationInView: self].x / 80, 0);
            [myAnimator addBehavior: push];
            break;
        }

        case UIGestureRecognizerStateEnded:
        {
            [myAnimator removeBehavior: push];
            break;
        }
        
        default:
            break;
    }
}

- (void)addDynamicBehavior {
    myAnimator = [[UIDynamicAnimator alloc] initWithReferenceView: self];
    myAnimator.delegate = self;
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems: ballsArray];
    collision.translatesReferenceBoundsIntoBoundary = YES;
    [myAnimator addBehavior: collision];
    for (NSInteger i = 0; i < 5; i++) {
        UIAttachmentBehavior *attachment = [[UIAttachmentBehavior alloc] initWithItem: ballsArray[i] attachedToAnchor: CGPointMake(kScreen.size.width / 2 + (i - 2) * 40, kScreen.size.height / 2 - 200)];
        [myAnimator addBehavior: attachment];
    }
    UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems: ballsArray];
    gravity.magnitude = 10;
    [myAnimator addBehavior: gravity];
    UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems: ballsArray];
    item.elasticity = 1;
    item.resistance = 1;
    item.allowsRotation = NO;
    [myAnimator addBehavior: item];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    [self setNeedsDisplay];
}

@end
