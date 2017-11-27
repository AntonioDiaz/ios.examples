//
//  CategoriesViewController.m
//  LocalSports
//
//  Created by cice on 27/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "CategoriesViewController.h"

@interface CategoriesViewController ()

@end

@implementation CategoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.backBarButtonItem
    NSLog(@"sport selected %@", self.sportSelected);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
