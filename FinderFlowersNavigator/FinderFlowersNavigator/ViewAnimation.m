//
//  ViewAnimation.m
//  FinderFlowersNavigator
//
//  Created by cice on 8/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewAnimation.h"

@implementation ViewAnimation

-(id) init {
    if (self = [super init]) {
        self.dismissDuration = 1.0;
        self.presentationDuration = 1.0;
        self.isPresented = false;
    }
    return self;
}

#pragma mark - UIViewControllerAnimatedTransitioning
-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isPresented) {
        return self.presentationDuration;
    } else {
        return self.dismissDuration;
    }
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *viewsSandbox = transitionContext.containerView;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    //on animation container put target view over the origin view
    [viewsSandbox insertSubview:toViewController.view aboveSubview:fromViewController.view];
    
    //Move down target view
    toViewController.view.frame = CGRectMake(0, viewsSandbox.frame.size.height, toViewController.view.frame.size.width, toViewController.view.frame.size.height);
    
    //animate target view
    [UIView animateWithDuration:1.0 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toViewController.view.frame = CGRectMake(0, 0, toViewController.view.frame.size.width, toViewController.view.frame.size.height);
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:true];
    }];
}

@end
