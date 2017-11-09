//
//  ViewAnimation.h
//  FinderFlowersNavigator
//
//  Created by cice on 8/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ViewAnimation : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) NSTimeInterval presentationDuration;
@property (nonatomic, assign) NSTimeInterval dismissDuration;
@property (nonatomic, assign) BOOL isPresented;

@end
