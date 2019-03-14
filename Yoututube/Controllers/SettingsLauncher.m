//
//  SettingsLauncher.m
//  Yoututube
//
//  Created by JonasC on 12/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "SettingsLauncher.h"
#import "SettingCell.h"
#import "Setting.h"

@interface SettingsLauncher () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *blackView;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray <Setting *> *settings;

@end

static NSString *const kCellId = @"cellId";
static CGFloat kCellHeight = 50.0f;

@implementation SettingsLauncher

- (UIView *)blackView {
    if(!_blackView) {
        _blackView = [[UIView alloc] init];
    }
    return _blackView;
}

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

- (NSArray<Setting *> *)settings {
    if(!_settings) {
        _settings = @[
                      [[Setting alloc] initWithName:@"Settings" withImageName:@"settings"],
                      [[Setting alloc] initWithName:@"Terms & Privacy policy" withImageName:@"privacy"],
                      [[Setting alloc] initWithName:@"Send Feedback" withImageName:@"feedback"],
                      [[Setting alloc] initWithName:@"Help" withImageName:@"help"],
                      [[Setting alloc] initWithName:@"Switch Account" withImageName:@"switch_account"],
                      [[Setting alloc] initWithName:@"Cancel" withImageName:@"cancel"],
                    ];
    }
    return _settings;
}

- (instancetype)init {
    self = [super init];
    [self.collectionView registerClass:[SettingCell class] forCellWithReuseIdentifier:kCellId];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    return self;
}

- (void)showSettings {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if(window) {
        self.blackView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        [self.blackView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDismiss)]];
        
        [window addSubview:self.blackView];
        [window addSubview:self.collectionView];
        
        CGFloat height = ((CGFloat)self.settings.count) * kCellHeight;
        CGFloat y = window.frame.size.height - height;
        self.collectionView.frame = CGRectMake(0, window.frame.size.height, window.frame.size.width, height);
        
        self.blackView.frame = window.frame;
        self.blackView.alpha = 0.0;
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.blackView.alpha = 1.0;
            
            self.collectionView.frame = CGRectMake(0, y, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
        } completion:nil];
    }
}

- (void)handleDismiss {
    [UIView animateWithDuration:0.5 animations:^{
        self.blackView.alpha = 0.0;
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        if(window) {
            self.collectionView.frame = CGRectMake(0, window.frame.size.height, self.collectionView.frame.size.width, self.collectionView.frame.size.height);
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.settings.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    Setting *setting = [self.settings objectAtIndex:indexPath.item];
    SettingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    cell.setting = setting;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, kCellHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self handleDismiss];
}

@end
