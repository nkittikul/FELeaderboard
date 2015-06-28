//
//  AppDelegate.m
//  FELeaderboard
//
//  Created by Narin Kittikul on 10/8/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "AppDelegate.h"
#import "LeaderboardViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.leaderboardViewController = [[LeaderboardViewController alloc] init];
    self.window.rootViewController = self.leaderboardViewController;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
