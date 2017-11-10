//
//  DataViewController.m
//  pagesExplanation
//
//  Created by cice on 9/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "DataViewController.h"

@interface DataViewController ()

@end

@implementation DataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataLabel.text = [self.dataObject objectForKey:@"key_country"];
    self.labelCityName.text = [self.dataObject objectForKey:@"key_city"];
    self.imageViewCity.image = [UIImage imageNamed:[self.dataObject objectForKey:@"key_image"]];
    self.pageControl.numberOfPages = self.pagesNum;
    self.pageControl.currentPage = self.currentPage;
}

@end
