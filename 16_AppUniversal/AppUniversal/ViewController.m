//
//  ViewController.m
//  AppUniversal
//
//  Created by cice on 8/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        [self.buttonWellcome setTitle:@"toma toma iPhone" forState:UIControlStateNormal];
    } else {
        [self.buttonWellcome setTitle:@"toma toma NOT iPhone" forState:UIControlStateNormal];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
