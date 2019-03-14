//
//  SettingsCell.m
//  Yoututube
//
//  Created by JonasC on 12/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "SettingCell.h"
#import "UIView+Constraints.h"

@interface SettingCell ()

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;

@end

@implementation SettingCell

- (void)setHighlighted:(BOOL)highlighted {
    self.backgroundColor = highlighted ? [UIColor darkGrayColor] : [UIColor whiteColor];
    self.nameLabel.textColor = highlighted ? [UIColor whiteColor] : [UIColor blackColor];
    self.iconImageView.tintColor = highlighted ? [UIColor whiteColor] : [UIColor darkGrayColor];
}

- (UILabel *)nameLabel {
    if(!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.text = @"Setting";
    }
    return _nameLabel;
}

- (UIImageView *)iconImageView {
    if(!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = [UIImage imageNamed:@"settings"];
        _iconImageView.contentMode = UIViewContentModeScaleToFill;
    }
    return _iconImageView;
}

- (void)setSetting:(Setting *)setting {
    self.nameLabel.text = setting.name;
    
    if(setting.imageName) {
        self.iconImageView.image = [[UIImage imageNamed:setting.imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        self.iconImageView.tintColor = [UIColor darkGrayColor];
    }
}

- (void)setupViews {
    [super setupViews];
    
    [self addSubview:self.nameLabel];
    [self addSubview:self.iconImageView];
    
    [self addConstraintsWithVisualFormat:@"H:|-8-[v0(30)]-8-[v1]|" withViews:_iconImageView, _nameLabel, nil];
    [self addConstraintsWithVisualFormat:@"V:|[v0]|" withViews:_nameLabel, nil];
    [self addConstraintsWithVisualFormat:@"V:[v0(30)]" withViews:_iconImageView, nil];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_iconImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

@end
