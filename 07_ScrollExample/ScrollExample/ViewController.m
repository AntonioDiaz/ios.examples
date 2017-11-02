//
//  ViewController.m
//  ScrollExample
//
//  Created by cice on 30/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    int myWidth = self.scroller.frame.size.width;
    int yLabelOutPosition = self.labelOut.frame.origin.y;
    int labelOutHeight = self.labelOut.frame.size.height;
    self.scroller.contentSize = CGSizeMake(myWidth, yLabelOutPosition + labelOutHeight + 40);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
