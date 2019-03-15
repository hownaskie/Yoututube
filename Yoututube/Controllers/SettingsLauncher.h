//
//  SettingsLauncher.h
//  Yoututube
//
//  Created by JonasC on 12/03/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HomeController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, SettingName) {
    Settings,
    TermsPrivacy,
    Feedback,
    Help,
    SwitchAccount,
    Cancel
};

@interface SettingsLauncher : NSObject

@property (nonatomic, strong) HomeController *homeController;

- (void)showSettings;

@end

NS_ASSUME_NONNULL_END
