//
//  ColorUtils.h
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/24.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define RGB(r, g, b, a) [UIColor colorWithRed: r green: g blue: b alpha: a]

@interface ColorUtils : NSObject

+ (UIColor *)randomColor;
+ (UIColor *)colorOverlayWithBasicColor: (UIColor *)basicColor mixColor: (UIColor *)mixColor;

@end
