//
//  ViewController.m
//  Resizeing03
//
//  Created by cice on 7/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view = self.viewVertical;
    NSLog(@"%d", self.interfaceOrientation);
//    UIDeviceOrientation *orientation = [[UIDevice currentDevice] orientation];
    if (UIDeviceOrientationIsLandscape(self.interfaceOrientation)) {
        self.view = self.viewHorizontal;
    } else {
        self.view = self.viewVertical;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    NSLog(@"rotate %d", toInterfaceOrientation);
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
