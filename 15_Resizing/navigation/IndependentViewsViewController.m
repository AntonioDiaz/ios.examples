//
//  IndependentViewsViewController.m
//  navigation
//
//  Created by Antonio Díaz Arroyo on 9/11/17.
//  Copyright © 2017 Antonio Díaz Arroyo. All rights reserved.
//

#import "IndependentViewsViewController.h"

@interface IndependentViewsViewController ()

@end

@implementation IndependentViewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Independent views";
    self.view = self.viewVertical;
    if (UIDeviceOrientationIsLandscape(self.interfaceOrientation)) {
        self.view = self.viewHorizontal;
    } else {
        self.view = self.viewVertical;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation==UIInterfaceOrientationPortrait || toInterfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) {
        self.view = self.viewVertical;
    } else {
        self.view = self.viewHorizontal;
    }
}


-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;
}

@end
