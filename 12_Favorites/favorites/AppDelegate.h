//
//  AppDelegate.h
//  favorites
//
//  Created by cice on 3/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Favorites.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    Favorites *favorites;
}

@property (strong, nonatomic) UIWindow *window;
@property Favorites *favorites;

@end

