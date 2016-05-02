//
//  AttachmentView.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/23.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "AttachmentView.h"
#import "SquareView.h"
#import "GravityWithCollisionBehavior.h"

@implementation AttachmentView
{
    UIDynamicAnimator *myAnimator;
    SquareView *square;
    UIAttachmentBehavior *attachmentBehavior;
    UIPanGestureRecognizer *panGesture;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        
        square = [[SquareView alloc] init];
        square.center = CGPointMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2, CGRectGetHeight([UIScreen mainScreen].bounds) - 40);
        [self addSubview: square];
        
        myAnimator = [[UIDynamicAnimator alloc] initWithReferenceView: self];
        myAnimator.delegate = self;
        
        //自定义行为
        //1.将官方的行为包装，实现自己想要的组合
        //（1）继承UIDynamicBehavior
        //（2）提供初始化方法initWithItems:，添加想要组合的行为
        //（3）使用
        //2.完全定义新的计算规则
        //（1）继承UIDynamicBehavior
        //（2）在@prpperty (nonatomic, copy) void (^action)(void)，执行需要的行为
        GravityWithCollisionBehavior *gravityWithCollisionBehavior = [[GravityWithCollisionBehavior alloc] initWithItems: @[square]];
        [myAnimator addBehavior: gravityWithCollisionBehavior];
//        UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems: @[square]];
//        [animator addBehavior: gravityBehavior];
//        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems: @[square]];
//        collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
//        [animator addBehavior: collisionBehavior];
        
        panGesture = [[UIPanGestureRecognizer alloc] initWithTarget: self action: @selector(handlerAttachmentGesture:)];
        [self addGestureRecognizer: panGesture];
    }
    return self;
}

- (void)handlerAttachmentGesture: (UIPanGestureRecognizer *)gesture {
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
        {
            CGPoint anchor = [gesture locationInView: self];
            NSLog(@"%@", NSStringFromCGRect(square.frame));
            //UIAttachmentBehavior:吸附行为，可以理解为用木棍（没有想变）或者弹簧（弹性形变）连接两View或者一个View一个锚点
            attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem: square offsetFromCenter: UIOffsetMake(0, - 40) attachedToAnchor: anchor];
            attachmentBehavior.length = 100;
            attachmentBehavior.damping = 0.3;
            [myAnimator addBehavior: attachmentBehavior];
            break;
        }
        
        case UIGestureRecognizerStateChanged:
        {
            [attachmentBehavior setAnchorPoint: [gesture locationInView: self]];
            break;
        }

        case UIGestureRecognizerStateEnded:
        {
            [myAnimator removeBehavior: attachmentBehavior];
            break;
        }
            
        default:
            break;
    }
}

- (void)dynamicAnimatorWillResume:(UIDynamicAnimator *)animator {
        NSLog(@"Running");
}

- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator {
    NSLog(@"Pause");
}

@end
