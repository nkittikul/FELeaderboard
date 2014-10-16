//
//  AppDelegate.h
//  FELeaderboard
//
//  Created by Narin Kittikul on 10/8/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeaderboardViewController.h"

@class JSONDataManager;
@class LeaderboardViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) LeaderboardViewController *leaderboardViewController;

@end
