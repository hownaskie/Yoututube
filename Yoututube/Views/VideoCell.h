//
//  VideoCell.h
//  Yoututube
//
//  Created by JonasC on 07/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "Video.h"

NS_ASSUME_NONNULL_BEGIN

@interface VideoCell : BaseCell

@property (nonatomic, strong) Video *video;

@end

NS_ASSUME_NONNULL_END
