//
//  AppDelegate.h
//  BarcelonaPublicTransport
//
//  Created by cice on 22/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

