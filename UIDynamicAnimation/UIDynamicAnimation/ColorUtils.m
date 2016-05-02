//
//  ColorUtils.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/24.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "ColorUtils.h"

@implementation ColorUtils

+ (UIColor *)colorOverlayWithBasicColor: (UIColor *)basicColor mixColor: (UIColor *)mixColor {
    const CGFloat *componentsBasic = CGColorGetComponents(basicColor.CGColor);
    const CGFloat *componentsMix = CGColorGetComponents(mixColor.CGColor);
    CGFloat redValue = 0, greenValue = 0, blueValue = 0;
    redValue = (componentsBasic[0] + componentsMix[0]) / 2;
    greenValue = (componentsBasic[1] + componentsMix[1]) / 2;
    blueValue = (componentsBasic[2] + componentsMix[2]) / 2;
    return RGB(redValue, greenValue, blueValue, 1);
}

+ (UIColor *)randomColor {
    CGFloat redValue = arc4random() % 255 / 255.0;
    CGFloat greenValue = arc4random() % 255 / 255.0;
    CGFloat blueValue = arc4random() % 255 / 255.0;
    return RGB(redValue, greenValue, blueValue, 1);
}

@end
