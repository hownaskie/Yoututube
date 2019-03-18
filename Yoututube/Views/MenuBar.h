//
//  MenuBar.h
//  Yoututube
//
//  Created by JonasC on 07/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuBar : UIView

@property (nonatomic, strong) HomeController *homeController;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSLayoutConstraint *horizontalBarLeftAnchorConstraint;

@end

NS_ASSUME_NONNULL_END
