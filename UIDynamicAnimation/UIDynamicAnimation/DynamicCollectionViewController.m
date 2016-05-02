//
//  DynamicCollectionViewController.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/24.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "DynamicCollectionViewController.h"
#import "BMuSpringCollectionViewFlowLayout.h"
#import "ColorUtils.h"

@interface DynamicCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) BMuSpringCollectionViewFlowLayout *myLayout;

@end

static NSString *identifier = @"cell";

@implementation DynamicCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.myLayout = [[BMuSpringCollectionViewFlowLayout alloc] init];
    self.myLayout.itemSize = CGSizeMake(CGRectGetWidth(self.view.frame), 44);
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame: [UIScreen mainScreen].bounds collectionViewLayout: self.myLayout];
    [collectionView registerClass: [UICollectionViewCell class] forCellWithReuseIdentifier: identifier];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [self.view addSubview: collectionView];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: identifier forIndexPath: indexPath];
    cell.contentView.backgroundColor = [ColorUtils randomColor];
    return cell;
}


@end
