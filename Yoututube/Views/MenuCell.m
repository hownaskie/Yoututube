//
//  MenuCell.m
//  Yoututube
//
//  Created by JonasC on 07/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "MenuCell.h"
#import "UIView+Constraints.h"
#import "UIColor+RgbColor.h"

@interface MenuCell ()

@end

@implementation MenuCell

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _imageView.tintColor = [UIColor rgbWithRed:91 green:14 blue:13];
    }
    return _imageView;
}

- (void)setHighlighted:(BOOL)highlighted {
    _imageView.tintColor = highlighted ? [UIColor whiteColor] : [UIColor rgbWithRed:91 green:14 blue:13];
}

- (void)setSelected:(BOOL)selected {
    _imageView.tintColor = selected ? [UIColor whiteColor] : [UIColor rgbWithRed:91 green:14 blue:13];
}

- (void)setupViews {
    [super setupViews];
    
    [self addSubview:self.imageView];
    [self addConstraintsWithVisualFormat:@"H:[v0(28)]" withViews:_imageView, nil];
    [self addConstraintsWithVisualFormat:@"V:[v0(28)]" withViews:_imageView, nil];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

@end
