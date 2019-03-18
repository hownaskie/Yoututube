//
//  ApiService.m
//  Yoututube
//
//  Created by JonasC on 19/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "ApiService.h"

@implementation ApiService

static ApiService *sharedInstance;

+ (ApiService *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[ApiService alloc] init];
    });
    return sharedInstance;
}

- (NSString *)baseUrl {
    return @"https://s3-us-west-2.amazonaws.com/youtubeassets/";
}

- (void)fetchVideosWithCompletion:(void(^)(NSMutableArray <Video *> *videos))completion {
    [self fetchFeedForUrlString:[NSString stringWithFormat:@"%@%@", [self baseUrl], @"home.json"] withCompletion:completion];
}

- (void)fetchTrendingsWithCompletion:(void(^)(NSMutableArray <Video *> *videos))completion {
    [self fetchFeedForUrlString:[NSString stringWithFormat:@"%@%@", [self baseUrl], @"trending.json"] withCompletion:completion];
}

- (void)fetchSubscriptionsWithCompletion:(void(^)(NSMutableArray <Video *> *videos))completion {
    [self fetchFeedForUrlString:[NSString stringWithFormat:@"%@%@", [self baseUrl], @"subscriptions.json"] withCompletion:completion];
}

- (void)fetchFeedForUrlString:(NSString *)urlString withCompletion:(void(^)(NSMutableArray <Video *> *videos))completion {
    NSURL *url = [NSURL URLWithString:urlString];
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if(error) return;
        
        NSError *jsonError = nil;
        NSArray *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonError];
        if(jsonError) return;
        
        NSMutableArray <Video *> *videos = [[NSMutableArray alloc] init];
        
        for(NSDictionary *dictionary in json) {
            Video *video = [[Video alloc] init];
            video.title = dictionary[@"title"];
            video.thumbnailImageName = dictionary[@"thumbnail_image_name"];
            video.numberOfViews = dictionary[@"number_of_views"];
            
            NSDictionary *channelDictionary = dictionary[@"channel"];
            
            Channel *channel = [[Channel alloc] init];
            channel.name = channelDictionary[@"name"];
            channel.profileImageName = channelDictionary[@"profile_image_name"];
            video.channel = channel;
            
            [videos addObject:video];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if(completion) completion(videos);
        });
    }] resume];
}

@end
