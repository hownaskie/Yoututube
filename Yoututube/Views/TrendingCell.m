//
//  TrendingCell.m
//  Yoututube
//
//  Created by JonasC on 19/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "TrendingCell.h"
#import "ApiService.h"

@implementation TrendingCell

- (void)fetchVideos {
    [[ApiService sharedInstance] fetchTrendingsWithCompletion:^(NSMutableArray<Video *> * _Nonnull videos) {
        self.videos = videos;
        [self.collectionView reloadData];
    }];
}

@end
