//
//  AppDelegate.m
//  Yoututube
//
//  Created by JonasC on 15/02/2019.
//  Copyright © 2019 JonasC. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeController.h"
#import "UIColor+RgbColor.h"
#import "UIView+Constraints.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[HomeController alloc] initWithCollectionViewLayout:layout]];
    
    //get rid of black bar underneath navbar
    [UINavigationBar appearance].barTintColor = [UIColor rgbWithRed:230 green:32 blue:31];
    [UINavigationBar appearance].shadowImage = [[UIImage alloc] init];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    application.statusBarStyle = UIStatusBarStyleLightContent;
    
    UIView *statusBarBackgroundView = [[UIView alloc] init];
    statusBarBackgroundView.backgroundColor = [UIColor rgbWithRed:194 green:31 blue:31];
    
    [self.window addSubview:statusBarBackgroundView];
    [self.window addConstraintsWithVisualFormat:@"H:|[v0]|" withViews:statusBarBackgroundView, nil];
    [self.window addConstraintsWithVisualFormat:@"V:|[v0(20)]" withViews:statusBarBackgroundView, nil];    
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
