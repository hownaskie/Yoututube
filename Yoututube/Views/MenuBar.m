//
//  MenuBar.m
//  Yoututube
//
//  Created by JonasC on 07/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "MenuBar.h"
#import "MenuCell.h"
#import "UIView+Constraints.h"
#import "UIColor+RgbColor.h"

@interface MenuBar () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *imageNames;

@property (nonatomic, strong) NSLayoutConstraint *horizontalBarLeftAnchorConstraint;

@end

static NSString *const kCellId = @"cellId";

@implementation MenuBar

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor rgbWithRed:230 green:32 blue:31];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (NSArray *)imageNames {
    if(!_imageNames) {
        _imageNames = @[@"home", @"hot", @"playlist", @"profile"];
    }
    return _imageNames;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self.collectionView registerClass:[MenuCell class] forCellWithReuseIdentifier:kCellId];
    
    [self addSubview:self.collectionView];
    [self addConstraintsWithVisualFormat:@"H:|[v0]|" withViews:_collectionView, nil];
    [self addConstraintsWithVisualFormat:@"V:|[v0]|" withViews:_collectionView, nil];
    
    NSIndexPath *selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.collectionView selectItemAtIndexPath:selectedIndexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    
    [self setupHorizontalBar];
    
    return self;
}

- (void)setupHorizontalBar {
    UIView *horizontalBarView = [[UIView alloc] init];
    horizontalBarView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    horizontalBarView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:horizontalBarView];
    
    self.horizontalBarLeftAnchorConstraint = [horizontalBarView.leftAnchor constraintEqualToAnchor:self.leftAnchor];
    self.horizontalBarLeftAnchorConstraint.active = YES;
    
    CGFloat horizontalBarViewWidth = [UIScreen mainScreen].bounds.size.width / 4;
    [horizontalBarView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [horizontalBarView.widthAnchor constraintEqualToConstant:horizontalBarViewWidth].active = YES;
    [horizontalBarView.heightAnchor constraintEqualToConstant:4].active = YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    cell.imageView.image = [[UIImage imageNamed:[self.imageNames objectAtIndex:indexPath.item]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    cell.tintColor = [UIColor rgbWithRed:91 green:14 blue:13];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.frame.size.width / 4, self.frame.size.height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat x = ((CGFloat)indexPath.item) * self.frame.size.width / 4;
    self.horizontalBarLeftAnchorConstraint.constant = x;
    
    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];
    } completion:nil];
}

@end
