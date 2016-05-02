//
//  UIView+Addition.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/24.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "UIView+Addition.h"

@implementation UIView (Addition)

- (void)setOriginX:(CGFloat)originX {
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
    return;
}

- (CGFloat)originX {
    return self.frame.origin.x;
}

- (void)setOriginY:(CGFloat)originY {
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
    return;
}

- (CGFloat)originY {
    return self.frame.origin.y;
}

- (void)setRightX:(CGFloat)rightX {
    CGRect frame = self.frame;
    frame.origin.x = rightX - self.width;
    self.frame = frame;
    return;
}

- (CGFloat)rightX {
    return self.originX + self.width;
}

- (void)setBottomY:(CGFloat)bottomY {
    CGRect frame = self.frame;
    frame.origin.y = bottomY - self.height;
    self.frame = frame;
    return;
}

- (CGFloat)bottomY {
    return self.originY + self.height;
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.originX, self.originY, width, self.height);
    return;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.originX, self.originY, self.width, height);
    return;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.centerY);
    return;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.centerX, centerY);
    return;
}

- (CGFloat)centerY {
    return self.center.y;
}

@end
