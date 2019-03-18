//
//  FeedCell.h
//  Yoututube
//
//  Created by JonasC on 19/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "BaseCell.h"
#import "Video.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedCell : BaseCell

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<Video *> *videos;

- (void)fetchVideos;

@end

NS_ASSUME_NONNULL_END
