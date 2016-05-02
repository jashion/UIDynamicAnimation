//
//  SquareView.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/22.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "SquareView.h"

@implementation SquareView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.800 green:1.000 blue:0.800 alpha:1.000];
        self.bounds = CGRectMake(0, 0, 80, 80);
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    }
    return self;
}

@end
