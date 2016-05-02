//
//  BaseViewController.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/22.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "BaseViewController.h"

@implementation BaseViewController
{
    NSString *viewName;
}

- (instancetype)initWithTitle: (NSString *)title viewName: (NSString *)className {
    self = [super init];
    if (self) {
        viewName = className;
        [self.navigationItem setTitle: title];
    }
    return self;
}

- (void)loadView {
    self.view = [[NSClassFromString(viewName) alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
