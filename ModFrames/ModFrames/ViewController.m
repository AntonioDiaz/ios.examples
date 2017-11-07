//
//  ViewController.m
//  ModFrames
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
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        self.labelTitle.frame = CGRectMake(self.labelTitle.frame.origin.x, 177,  self.labelTitle.frame.size.width, self.labelTitle.frame.size.height);
    }
}


@end
