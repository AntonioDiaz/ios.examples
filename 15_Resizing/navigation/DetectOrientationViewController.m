//
//  DetectOrientationViewController.m
//  navigation
//
//  Created by Antonio Díaz Arroyo on 8/11/17.
//  Copyright © 2017 Antonio Díaz Arroyo. All rights reserved.
//

#import "DetectOrientationViewController.h"

@interface DetectOrientationViewController ()

@end

@implementation DetectOrientationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Detect Orientation.";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.labelTitle.frame = CGRectMake(self.labelTitle.frame.origin.x, 177,  self.labelTitle.frame.size.width, self.labelTitle.frame.size.height);
    }
}

@end
