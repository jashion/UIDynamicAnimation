//
//  ViewController.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/22.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"
#import "DynamicCollectionViewController.h"

#define itemName @"name"
#define className @"class"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *dynamicItems;

@end

@implementation ViewController

#pragma mark - getter and setter

//对于UIDynamicItem来说，当它们被添加到动画系统后，我们只能通过动画系统来改变位置，而外部的对于UIDynamicItem的center,transform等设定是被忽略的（其实这也是大多数2D引擎的实现策略，算不上限制）。

- (NSArray *)dynamicItems {
    if (_dynamicItems == nil) {
        _dynamicItems = @[@{itemName: @"Gravity", className: @"GravityView"},
                          @{itemName: @"Collision", className: @"CollisionView"},
                          @{itemName: @"Attachment", className: @"AttachmentView"},
                          @{itemName: @"Snap", className: @"SnapView"},
                          @{itemName: @"Push", className: @"PushView"},
                          @{itemName: @"SnapAnimator", className: @"SnapDemo"},
                          @{itemName: @"AttachmentAnimator", className: @"AttachmentDemo"},
                          @{itemName: @"CollectionViewDemo", className: @"DynamicCollectionView"}];
    }
    return _dynamicItems;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dynamicItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell"];
    NSDictionary *dict = self.dynamicItems[indexPath.row];
    cell.textLabel.text = [dict objectForKey: itemName];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.dynamicItems[indexPath.row];
    if (indexPath.row == (self.dynamicItems.count - 1)) {
        DynamicCollectionViewController *controller = [[DynamicCollectionViewController alloc] init];
        [self.navigationController pushViewController: controller animated: YES];
        return;
    }
    BaseViewController *baseVC = [[BaseViewController alloc] initWithTitle: [dict objectForKey: itemName] viewName: [dict objectForKey: className]];
    [self.navigationController pushViewController: baseVC animated: YES];
}

@end
