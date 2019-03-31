//
//  VideoLauncher.m
//  Yoututube
//
//  Created by MAC on 31/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "VideoLauncher.h"
#import "VideoPlayerView.h"

@implementation VideoLauncher

- (void)showVideoPlayer {
    NSLog(@"hello");
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if(keyWindow) {
        UIView *view = [[UIView alloc] initWithFrame:keyWindow.frame];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(keyWindow.frame.size.width - 10, keyWindow.frame.size.height - 10, 10, 10);
        
        //16 * 9 is the aspect ratio of all HD videos
        CGFloat height = keyWindow.frame.size.width * 9 / 16;
        CGRect videoPlayerFrame = CGRectMake(0, 0, keyWindow.frame.size.width, height);
        VideoPlayerView *videoPlayerView = [[VideoPlayerView alloc] initWithFrame:videoPlayerFrame];
        [view addSubview:videoPlayerView];
        
        [keyWindow addSubview:view];
        
        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            view.frame = keyWindow.frame;
        } completion:^(BOOL finished) {
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
        }];
    }
}

@end
