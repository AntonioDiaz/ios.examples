//
//  FormViewController.m
//  popovers
//
//  Created by cice on 9/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "FormViewController.h"

@interface FormViewController ()

@end

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions
- (IBAction)buttonOk:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    [self.popoverPresentationController.delegate popoverPresentationControllerDidDismissPopover:self.popoverPresentationController];
}

@end
