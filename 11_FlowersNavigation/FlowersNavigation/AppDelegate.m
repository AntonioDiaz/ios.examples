//
//  AppDelegate.m
//  FlowersNavigation
//
//  Created by cice on 2/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
    UITabBarController *tabBarController = (UITabBarController *) self.window.rootViewController;
    UITabBar *tabBar = tabBarController.tabBar;
    
    UITabBarItem *tabBarItemList = [tabBar.items objectAtIndex:0];
    UITabBarItem *tabBarItemGrid = [tabBar.items objectAtIndex:1];
    
    //change title
    tabBarItemList.title = @"List";
    tabBarItemGrid.title = @"Grid";
    
    //change image
    UIImage *imageList = [UIImage imageNamed:@"list.png"];
    UIImage *imageListSelected = [UIImage imageNamed:@"list_selected.jpg"];
    UIImage *imageGrid = [UIImage imageNamed:@"grid.png"];
    UIImage *imageGridSelected = [UIImage imageNamed:@"grid_selected.jpg"];

    //[tabBarItemList setFinishedSelectedImage:imageListSelected withFinishedUnselectedImage:imageList];
    //[tabBarItemGrid setFinishedSelectedImage:imageGridSelected withFinishedUnselectedImage:imageGrid];

    UIImage *imageBackground = [UIImage imageNamed:@"tab_bar_background.png"];
    [[UITabBar appearance] setBackgroundImage:imageBackground];
    //[[UITabBar appearance] secCol:imageBackground];
    
    //[[UINavigationBar appearance] setBarTintColor:[UIColor yellowColor]];
    [[UINavigationBar appearance] setBackgroundImage:imageBackground forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    //[[UINavigationBar appearance] setBackIndicatorImage:<#(UIImage * _Nullable)#>]
    
    NSShadow *sadow = [[NSShadow alloc] init];
    sadow.shadowColor = [UIColor blackColor];
    sadow.shadowOffset = CGSizeMake(1, 1);
    
    NSDictionary *titleAttributes = [[NSDictionary alloc] initWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, sadow, NSShadowAttributeName, nil];
    //[[UINavigationBar appearance] setTitleTextAttributes:titleAttributes];
     return true;
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
