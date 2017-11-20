//
//  ViewController.m
//  popovers
//
//  Created by cice on 9/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"
#import "FormViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)showActionSheet:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Actions"
                                            delegate:nil
                                            cancelButtonTitle:@"Close"
                                            destructiveButtonTitle:@"Delete"
                                            otherButtonTitles:@"Another button", nil];
    [actionSheet showInView:self.view];
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        [actionSheet showFromRect:[(UIButton*)sender frame] inView:self.view animated:true];
    } else {
        [actionSheet showInView:self.view];
    }
}

- (IBAction)showPopover:(id)sender {
    //Retrieveing the instance of viewController we want to show.
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FormViewController *formViewController = [storyBoard instantiateViewControllerWithIdentifier:@"IdFormViewController"];
    formViewController.modalPresentationStyle = UIModalPresentationPopover;
    
    //Config PopOverPresentationController
    UIPopoverPresentationController *popoverController = [formViewController popoverPresentationController];
    popoverController.delegate = self;
    popoverController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popoverController.barButtonItem = sender;
    
    //throw the popover
    [self presentViewController:formViewController animated:true completion:nil];

}

#pragma mark - PopoverPresentationController
-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    FormViewController *form = (FormViewController*)popoverPresentationController.presentedViewController;
    NSLog(@"%@", form.self.textFieldName.text);
}


@end
