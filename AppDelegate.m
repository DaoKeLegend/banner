//
//  AppDelegate.m
//  banner
//
//  Created by lucy on 2017/4/17.
//  Copyright © 2017年 com.qunar.com. All rights reserved.
//

#import "AppDelegate.h"
#import "JJBannerVC.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    JJBannerVC *bannerVC = [[JJBannerVC alloc] init];
    self.window.rootViewController = bannerVC;
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end
