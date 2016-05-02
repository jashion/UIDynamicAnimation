//
//  BallView.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/22.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "BallView.h"

@implementation BallView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.800 green:1.000 blue:0.800 alpha:1.000];
        self.bounds = CGRectMake(0, 0, 40, 40);
        self.layer.cornerRadius = 20;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.layer.borderWidth = 1;
    }
    return self;
}

@end
