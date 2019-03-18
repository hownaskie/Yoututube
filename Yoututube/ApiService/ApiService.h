//
//  ApiService.h
//  Yoututube
//
//  Created by JonasC on 19/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Video.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApiService : NSObject

+ (ApiService *)sharedInstance;
- (void)fetchVideosWithCompletion:(void(^)(NSMutableArray <Video *> *videos))completion;
- (void)fetchTrendingsWithCompletion:(void(^)(NSMutableArray <Video *> *videos))completion;
- (void)fetchSubscriptionsWithCompletion:(void(^)(NSMutableArray <Video *> *videos))completion;

@end

NS_ASSUME_NONNULL_END
