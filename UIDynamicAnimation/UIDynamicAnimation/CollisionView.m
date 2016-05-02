//
//  CollisionView.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/22.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "CollisionView.h"
#import "BallView.h"

@implementation CollisionView
{
    UIDynamicAnimator *myAnimator;
    BallView *ball;
    NSMutableArray *ballsArray2;
    NSMutableArray *ballsArray3;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        ballsArray2 = [@[] mutableCopy];
        ballsArray3 = [@[] mutableCopy];
        
        NSArray *operationName = @[@"自由落体", @"碰撞", @"多球碰撞"];
        for (NSInteger i = 0; i < operationName.count; i++) {
            UIButton *button = [UIButton buttonWithType: UIButtonTypeCustom];
            button.frame = CGRectMake(10 + i * 130, 80, 100, 30);
            button.backgroundColor = [UIColor lightGrayColor];
            button.tag = i;
            [button setTitle: operationName[i] forState: UIControlStateNormal];
            [button setTitleColor: [UIColor whiteColor] forState: UIControlStateNormal];
            [button addTarget: self action: @selector(addDynamicBehavior:) forControlEvents: UIControlEventTouchUpInside];
            [self addSubview: button];
        }
    }
    return self;
}

- (void)addDynamicBehavior: (id)sender {
    UIButton *button = (UIButton *)sender;
    myAnimator = [[UIDynamicAnimator alloc] initWithReferenceView: self];
    
    switch (button.tag) {
        case 0:
        {
            if (!ball) {
                ball = [[BallView alloc] init];
                ball.center = CGPointMake(60, 150);
                [self addSubview: ball];
            }
            
            UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems: @[ball]];
            [myAnimator addBehavior: gravity];
            UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems: @[ball]];
            collision.translatesReferenceBoundsIntoBoundary = YES;
            collision.collisionDelegate = self;
            [myAnimator addBehavior: collision];
            UIDynamicItemBehavior *behavior = [[UIDynamicItemBehavior alloc] init];
            behavior.elasticity = 0.8;
            behavior.friction = 0.2;
            behavior.resistance = 0.3;
            behavior.density = 0.5;
            behavior.angularResistance = 0.2;
            [behavior addItem: ball];
            [myAnimator addBehavior: behavior];
            break;
        }
            
        case 1:
        {
            if (!ballsArray2 || ballsArray2.count == 0) {
                BallView *ball_1 = [[BallView alloc] init];
                ball_1.center = CGPointMake(190, 150);
                [self addSubview: ball_1];
                
                BallView *ball_2 = [[BallView alloc] init];
                ball_2.center = CGPointMake(220, CGRectGetHeight([UIScreen mainScreen].bounds) - 20);
                [self addSubview: ball_2];
                
                BallView *ball_3 = [[BallView alloc] init];
                ball_3.center = CGPointMake(160, CGRectGetHeight([UIScreen mainScreen].bounds) - 20);
                [self addSubview: ball_3];
                
                [ballsArray2 addObject: ball_1];
                [ballsArray2 addObject: ball_2];
                [ballsArray2 addObject: ball_3];
            }
        
            UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems: @[ballsArray2[0]]];
            [myAnimator addBehavior: gravity];
            UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems: ballsArray2];
            collision.translatesReferenceBoundsIntoBoundary = YES;
            collision.collisionDelegate = self;
            [myAnimator addBehavior: collision];
            UIDynamicItemBehavior *behavior1 = [[UIDynamicItemBehavior alloc] initWithItems: @[ballsArray2[0]]];
            behavior1.elasticity = 0.5;
            [myAnimator addBehavior: behavior1];
            UIDynamicItemBehavior *behavior2 = [[UIDynamicItemBehavior alloc] initWithItems: @[ballsArray2[1]]];
            behavior2.elasticity = 0.5;
            behavior2.friction = 0.3;
            behavior2.resistance = 0.3;
            [myAnimator addBehavior: behavior2];
            UIDynamicItemBehavior *behavior3 = [[UIDynamicItemBehavior alloc] initWithItems: @[ballsArray2[2]]];
            behavior3.elasticity = 0.5;
            behavior3.friction = 0.3;
            behavior3.resistance = 0.3;
            [myAnimator addBehavior: behavior3];
            break;
        }
            
        case 2:
        {
        
            if (!ballsArray3 || ballsArray3.count == 0) {
                for (NSInteger i = 0; i < 4; i++) {
                    BallView *ball3 = [[BallView alloc] init];
                    ball3.center = CGPointMake(100 + i * 80, 300);
                    [self addSubview: ball3];
                    [ballsArray3 addObject: ball3];
                }
            }
        
            UIGravityBehavior *gravity = [[UIGravityBehavior  alloc] init];
            [gravity addItem: ballsArray3[0]];
            gravity.gravityDirection = CGVectorMake(1.0, 0.0);
            [myAnimator addBehavior: gravity];
            
            UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems: ballsArray3];
            collision.translatesReferenceBoundsIntoBoundary = YES;
            collision.collisionDelegate = self;
            [myAnimator addBehavior: collision];
            for (NSInteger i = 0; i < ballsArray3.count; i++) {
                UIDynamicItemBehavior *behavior = [[UIDynamicItemBehavior alloc] initWithItems: @[ballsArray3[i]]];
                behavior.elasticity = 0.5;
                behavior.density = i;
                [myAnimator addBehavior: behavior];
            }
            break;
        }
            
        default:
            break;
    }
    
}

#pragma mark - UICollisionBehaviorDelegate

- (void)collisionBehavior:(UICollisionBehavior*)behavior beganContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier atPoint:(CGPoint)p {
    NSLog(@"Began");
}
- (void)collisionBehavior:(UICollisionBehavior*)behavior endedContactForItem:(id <UIDynamicItem>)item withBoundaryIdentifier:(nullable id <NSCopying>)identifier {
    NSLog(@"End");
}

@end
