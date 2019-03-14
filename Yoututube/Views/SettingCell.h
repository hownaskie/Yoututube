//
//  SettingsCell.h
//  Yoututube
//
//  Created by JonasC on 12/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseCell.h"
#import "Setting.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettingCell : BaseCell

@property (nonatomic, strong) Setting *setting;

@end

NS_ASSUME_NONNULL_END
