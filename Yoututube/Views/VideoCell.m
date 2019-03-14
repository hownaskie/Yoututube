//
//  VideoCell.m
//  Yoututube
//
//  Created by JonasC on 07/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "VideoCell.h"
#import "UIView+Constraints.h"
#import "CustomImageView.h"

@interface VideoCell ()

@property (nonatomic, strong) CustomImageView *thumbnailImageView;
@property (nonatomic, strong) UIView *separatorView;
@property (nonatomic, strong) CustomImageView *userProfileImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *subtitleTextView;

@property (nonatomic, strong) NSLayoutConstraint *titleLabelHeightConstraint;
@end

@implementation VideoCell

- (UIImageView *)thumbnailView {
    if(!_thumbnailImageView) {
        _thumbnailImageView = [[CustomImageView alloc] init];
        _thumbnailImageView.image = [UIImage imageNamed:@"memory-of-the-wind"];
        _thumbnailImageView.contentMode = UIViewContentModeScaleAspectFill;
        _thumbnailImageView.clipsToBounds = YES;
    }
    return _thumbnailImageView;
}

- (UIView *)separatorView {
    if(!_separatorView) {
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.0];
    }
    return _separatorView;
}

- (UIImageView *)userProfileImageView {
    if(!_userProfileImageView) {
        _userProfileImageView = [[CustomImageView alloc] init];
        _userProfileImageView.image = [UIImage imageNamed:@"profile-thumbnail"];
        _userProfileImageView.contentMode = UIViewContentModeScaleAspectFill;
        _userProfileImageView.layer.cornerRadius = 22;
        _userProfileImageView.layer.masksToBounds = YES;
    }
    return _userProfileImageView;
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"NAUL(나얼) _ Memory Of The Wind(바람기억) MV";
    }
    return _titleLabel;
}

- (UITextView *)subtitleTextView {
    if(!_subtitleTextView) {
        _subtitleTextView = [[UITextView alloc] init];
        _subtitleTextView.translatesAutoresizingMaskIntoConstraints = NO;
        _subtitleTextView.text = @"NAULVEVO • 123,456,789 views • 2 years";
        _subtitleTextView.textContainerInset = UIEdgeInsetsMake(0, -4, 0, 0);
        _subtitleTextView.textColor = [UIColor lightGrayColor];
    }
    return _subtitleTextView;
}

- (void)setVideo:(Video *)video {
    _video = video; //should use weak reference to avoid bad access to variable
    
    self.titleLabel.text = video.title;
    
    [self setupThumbnailImage];
    
    [self setupProfileImage];
    
    if(video.channel.name) {
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        NSString *subtitle = [NSString stringWithFormat:@"%@ • %@ • %@", video.channel.name, [formatter stringFromNumber:video.numberOfViews], video.uploadDate];
        self.subtitleTextView.text = subtitle;
    }
    
    //measure title text
    if(video.title) {
        CGSize size = CGSizeMake(self.titleLabel.frame.size.width - 16 - 44 - 8 - 16, CGFLOAT_MAX);
        CGRect estimatedRect = [video.title boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.titleLabel.font} context:nil];
        if(estimatedRect.size.height > 20) {
            self.titleLabelHeightConstraint.constant = 44;
        } else {
            self.titleLabelHeightConstraint.constant = 20;
        }
    }
}

- (void)setupThumbnailImage {
    if(self.video.thumbnailImageName) {
        [self.thumbnailImageView loadImageUsingUrlString:self.video.thumbnailImageName];
    }
}

- (void)setupProfileImage {
    if(self.video.channel.profileImageName) {
        [self.userProfileImageView loadImageUsingUrlString:self.video.channel.profileImageName];
    }
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupViews];
    return self;
}

- (void)setupViews {
    [super setupViews];
    
    [self addSubview:self.thumbnailView];
    [self addSubview:self.separatorView];
    [self addSubview:self.userProfileImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleTextView];
    
    [self addConstraintsWithVisualFormat:@"H:|-16-[v0]-16-|" withViews:_thumbnailImageView, nil];
    [self addConstraintsWithVisualFormat:@"H:|-16-[v0(44)]" withViews:_userProfileImageView, nil];
    
    //vertical constraints
    [self addConstraintsWithVisualFormat:@"V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|" withViews:_thumbnailImageView, _userProfileImageView, _separatorView, nil];
    [self addConstraintsWithVisualFormat:@"H:|[v0]|" withViews:_separatorView, nil];
    
    //top constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_thumbnailImageView attribute:NSLayoutAttributeBottom multiplier:1 constant:8]];
    //left constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_userProfileImageView attribute:NSLayoutAttributeRight multiplier:1 constant:8]];
    //right constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_thumbnailImageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    //height constraint
    self.titleLabelHeightConstraint = [NSLayoutConstraint constraintWithItem:_titleLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:44];
    [self addConstraint:self.titleLabelHeightConstraint];
    
    
    //top constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_subtitleTextView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_titleLabel attribute:NSLayoutAttributeBottom multiplier:1 constant:4]];
    //left constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_subtitleTextView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_userProfileImageView attribute:NSLayoutAttributeRight multiplier:1 constant:8]];
    //right constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_subtitleTextView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_thumbnailImageView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    //height constraint
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_subtitleTextView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeHeight multiplier:0 constant:30]];
}

@end
