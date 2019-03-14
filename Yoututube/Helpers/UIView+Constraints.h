//
//  UIView+Constraints.h
//  Yoututube
//
//  Created by JonasC on 07/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Constraints)

- (void)addConstraintsWithVisualFormat:(NSString *)format withViews:(UIView *)views,...;

@end

NS_ASSUME_NONNULL_END
