//
//  ViewController.m
//  FlowersNavigation
//
//  Created by cice on 2/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize urlFlower;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString: urlFlower];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webViewFlower loadRequest:request];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
