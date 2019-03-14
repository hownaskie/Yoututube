//
//  UIColor+RgbColor.m
//  Yoututube
//
//  Created by JonasC on 07/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "UIColor+RgbColor.h"

@implementation UIColor (RgbColor)

+ (UIColor *)rgbWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue {
    return [UIColor colorWithRed:red/255 green:green/255 blue:blue/255 alpha:1];
}

@end
