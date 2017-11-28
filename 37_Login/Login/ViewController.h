//
//  ViewController.h
//  Login
//
//  Created by cice on 28/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldUsername;

@property (weak, nonatomic) IBOutlet UITextField *textFieldPassword;
- (IBAction)actionAccess:(id)sender;

@end

