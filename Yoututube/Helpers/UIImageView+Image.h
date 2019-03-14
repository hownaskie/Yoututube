//
//  UIImageView+Image.h
//  Yoututube
//
//  Created by JonasC on 09/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (Image)

@property (nonatomic, assign) NSCache *imageCache;

- (void)loadImageUsingUrlString:(NSString *)stringUrl;

@end

NS_ASSUME_NONNULL_END
