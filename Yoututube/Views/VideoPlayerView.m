//
//  VideoPlayerView.m
//  Yoututube
//
//  Created by MAC on 31/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "VideoPlayerView.h"

@interface VideoPlayerView ()

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) UIView *controlsContainerView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicatorView;
@property (nonatomic, strong) UIButton *pausePlayButton;

@property (nonatomic, assign) BOOL isPlaying;

@property (nonatomic, strong) UILabel *videoLengthLabel;
@property (nonatomic, strong) UISlider *videoSlider;

@end

@implementation VideoPlayerView

- (UIView *)controlsContainerView {
    if(!_controlsContainerView) {
        _controlsContainerView = [[UIView alloc] init];
        _controlsContainerView.backgroundColor = [UIColor colorWithWhite:0 alpha:1];
    }
    return _controlsContainerView;
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if(!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [_activityIndicatorView startAnimating];
        _activityIndicatorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _activityIndicatorView;
}

- (UIButton *)pausePlayButton {
    if(!_pausePlayButton) {
        UIImage *image = [[UIImage imageNamed:@"pause"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _pausePlayButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _pausePlayButton.translatesAutoresizingMaskIntoConstraints = NO;
        _pausePlayButton.tintColor = [UIColor whiteColor];
        _pausePlayButton.hidden = YES;
        [_pausePlayButton setImage:image forState:UIControlStateNormal];
        [_pausePlayButton addTarget:self action:@selector(handlePause) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pausePlayButton;
}

- (void)handlePause {
    if(self.isPlaying) {
        [self.player pause];
        UIImage *image = [[UIImage imageNamed:@"play"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.pausePlayButton setImage:image forState:UIControlStateNormal];
        self.pausePlayButton.tintColor = [UIColor whiteColor];
    } else {
        [self.player play];
        UIImage *image = [[UIImage imageNamed:@"pause"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [self.pausePlayButton setImage:image forState:UIControlStateNormal];
        self.pausePlayButton.tintColor = [UIColor whiteColor];
    }
    
    self.isPlaying = !self.isPlaying;
}

- (UILabel *)videoLengthLabel {
    if(!_videoLengthLabel) {
        _videoLengthLabel = [[UILabel alloc] init];
        _videoLengthLabel.text = @"00:00";
        _videoLengthLabel.textColor = [UIColor whiteColor];
        _videoLengthLabel.font = [UIFont boldSystemFontOfSize:14];
        _videoLengthLabel.textAlignment = NSTextAlignmentRight;
        _videoLengthLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _videoLengthLabel;
}

- (UISlider *)videoSlider {
    if(!_videoSlider) {
        _videoSlider = [[UISlider alloc] init];
        _videoSlider.translatesAutoresizingMaskIntoConstraints = NO;
        _videoSlider.minimumTrackTintColor = [UIColor redColor];
        _videoSlider.maximumTrackTintColor = [UIColor whiteColor];
        UIImage *image = [[UIImage imageNamed:@"thumbCircle"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        [_videoSlider setThumbImage:image forState:UIControlStateNormal];
        _videoSlider.thumbTintColor = [UIColor redColor];
        [_videoSlider addTarget:self action:@selector(handleSliderChange) forControlEvents:UIControlEventValueChanged];
    }
    return _videoSlider;
}

- (void)handleSliderChange {
    CMTime duration = self.player.currentItem.duration;
    if(duration.value) {
        int totalSeconds = CMTimeGetSeconds(duration);
        float64_t value = (float64_t)self.videoSlider.value * totalSeconds;
        CMTime seekTime = CMTimeMake((int64_t)value, 1);
        [self.player seekToTime:seekTime completionHandler:^(BOOL finished) {
            
        }];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self setupPlayerView];
    
    self.controlsContainerView.frame = frame;
    [self addSubview:self.controlsContainerView];
    
    [self.controlsContainerView addSubview:self.activityIndicatorView];
    [self.activityIndicatorView.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.activityIndicatorView.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    
    [self.controlsContainerView addSubview:self.pausePlayButton];
    [self.pausePlayButton.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
    [self.pausePlayButton.centerYAnchor constraintEqualToAnchor:self.centerYAnchor].active = YES;
    [self.pausePlayButton.widthAnchor constraintEqualToConstant:50].active = YES;
    [self.pausePlayButton.heightAnchor constraintEqualToConstant:50].active = YES;
    
    [self.controlsContainerView addSubview:self.videoLengthLabel];
    [self.videoLengthLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8].active = YES;
    [self.videoLengthLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.videoLengthLabel.widthAnchor constraintEqualToConstant:60].active = YES;
    [self.videoLengthLabel.heightAnchor constraintEqualToConstant:24].active = YES;
    
    [self.controlsContainerView addSubview:self.videoSlider];
    [self.videoSlider.rightAnchor constraintEqualToAnchor:self.videoLengthLabel.leftAnchor].active = YES;
    [self.videoSlider.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [self.videoSlider.leftAnchor constraintEqualToAnchor:self.leftAnchor].active = YES;
    [self.videoSlider.heightAnchor constraintEqualToConstant:30].active = YES;
    
    self.backgroundColor = [UIColor blackColor];
    
    return self;
}

- (void)setupPlayerView {
    
    NSString *urlString = @"https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4";
    NSURL *url = [NSURL URLWithString:urlString];
    if(url) {
        //init player
        self.player = [AVPlayer playerWithURL:url];
        //init player layer
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        playerLayer.frame = self.frame;
        [self.layer addSublayer:playerLayer];
        playerLayer.player = self.player;
        
        [self.player play];
        [self.player addObserver:self forKeyPath:@"currentItem.loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if([keyPath isEqualToString:@"currentItem.loadedTimeRanges"]) {
        [self.activityIndicatorView stopAnimating];
        self.controlsContainerView.backgroundColor = [UIColor clearColor];
        self.pausePlayButton.hidden = NO;
        self.isPlaying = YES;
        
        CMTime duration = self.player.currentItem.duration;
        if(duration.value) {
            int seconds = CMTimeGetSeconds(duration);
            int secondsText = (int)seconds % 60;
            int minutesText = (int)secondsText / 60;
            self.videoLengthLabel.text = [NSString stringWithFormat:@"%02d:%02d", minutesText, secondsText];
        }
    }
}

@end
