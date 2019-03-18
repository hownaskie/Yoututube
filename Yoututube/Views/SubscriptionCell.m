//
//  SubscriptionCell.m
//  Yoututube
//
//  Created by JonasC on 19/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "SubscriptionCell.h"
#import "ApiService.h"

@implementation SubscriptionCell

- (void)fetchVideos {
    [[ApiService sharedInstance] fetchSubscriptionsWithCompletion:^(NSMutableArray<Video *> * _Nonnull videos) {
        self.videos = videos;
        [self.collectionView reloadData];
    }];
}

@end
