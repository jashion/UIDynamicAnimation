//
//  BMuSpringCollectionViewFlowLayout.m
//  UIDynamicAnimation
//
//  Created by jashion on 16/4/24.
//  Copyright © 2016年 BMu. All rights reserved.
//

#import "BMuSpringCollectionViewFlowLayout.h"

@interface BMuSpringCollectionViewFlowLayout ()

@property (nonatomic, strong) UIDynamicAnimator *animator;

@end

@implementation BMuSpringCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout: self];
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *items = [super layoutAttributesForElementsInRect: CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for (UICollectionViewLayoutAttributes *item in items) {
            UIAttachmentBehavior *attachmenBehavior = [[UIAttachmentBehavior alloc] initWithItem: item attachedToAnchor: item.center];
            attachmenBehavior.length = 0;
            attachmenBehavior.damping = 0.5;
            attachmenBehavior.frequency = 0.8;
            [_animator addBehavior: attachmenBehavior];
        }
    }
}

//通过initWithCollectionViewLayout:方法，animator和改layout绑定了，所以涉及UICollectionViewLayoutAttributes都应该由animator给出

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    return [_animator itemsInRect: rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_animator layoutAttributesForCellAtIndexPath: indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    UIScrollView *scrollView = self.collectionView;
    CGFloat scrollDalta = newBounds.origin.y - scrollView.bounds.origin.y;
    NSLog(@"newBounds.origin.y: %lf &&  scrollView.bounds.origin.y: %lf", newBounds.origin.y, scrollView.bounds.origin.y);
    CGPoint touchLocation = [scrollView.panGestureRecognizer locationInView: scrollView];
    
    for (UIAttachmentBehavior *attachmentBehavior in _animator.behaviors) {
        CGPoint anchorPoint = attachmentBehavior.anchorPoint;
        
        CGFloat distanceFromTouch = fabs(touchLocation.y - anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / 1000;
        
        UICollectionViewLayoutAttributes *item = (UICollectionViewLayoutAttributes *)[attachmentBehavior.items firstObject];
        CGPoint center = item.center;
        
        center.y += (scrollDalta > 0) ? MIN(scrollDalta, scrollDalta * scrollResistance) : MAX(scrollDalta, scrollDalta * scrollResistance);
    
        item.center = center;
        [_animator updateItemUsingCurrentState: item];
    }
    
    return NO;
}

@end
