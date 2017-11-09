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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)buttonOk:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    [self.popoverPresentationController.delegate popoverPresentationControllerDidDismissPopover:self.popoverPresentationController];
}

@end
