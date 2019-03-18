//
//  FeedCell.m
//  Yoututube
//
//  Created by JonasC on 19/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "FeedCell.h"
#import "UIView+Constraints.h"

#import "VideoCell.h"

#import "ApiService.h"

@interface FeedCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

static NSString *const kCellId = @"kCellId";

@implementation FeedCell

- (void)fetchVideos {
    [[ApiService sharedInstance] fetchVideosWithCompletion:^(NSMutableArray<Video *> * _Nonnull videos) {
        self.videos = videos;
        [self.collectionView reloadData];
    }];
}

- (NSMutableArray<Video *> *)videos {
    if(!_videos) {
        _videos = [[NSMutableArray alloc] init];
    }
    return _videos;
}

- (UICollectionView *)collectionView {
    if(!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return _collectionView;
}

- (void)setupViews {
    [super setupViews];
    
    [self fetchVideos];
    
    [self addSubview:self.collectionView];
    [self addConstraintsWithVisualFormat:@"H:|[v0]|" withViews:_collectionView, nil];
    [self addConstraintsWithVisualFormat:@"V:|[v0]|" withViews:_collectionView, nil];
    
    [self.collectionView registerClass:[VideoCell class] forCellWithReuseIdentifier:kCellId];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(self.videos.count > 0) {
        return self.videos.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    VideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId forIndexPath:indexPath];
    if(self.videos.count > 0) {
        cell.video = [self.videos objectAtIndex:indexPath.item];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = (self.frame.size.width - 16 - 16) * 9 / 16;
    return CGSizeMake(self.frame.size.width, height + 16 + 88);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

@end
