//
//  GravityWithCollisionBehavior.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/23.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "GravityWithCollisionBehavior.h"

@implementation GravityWithCollisionBehavior

- (instancetype)initWithItems: (NSArray *)items {
    self = [super init];
    if (self) {
        UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems: items];
        [self addChildBehavior: gravityBehavior];
        UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc] initWithItems: items];
        collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
        [self addChildBehavior: collisionBehavior];
    }
    return self;
}

@end
