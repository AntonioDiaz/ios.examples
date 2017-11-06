//
//  FirstViewController.h
//  favorites
//
//  Created by cice on 3/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldUrl;
@property (weak, nonatomic) IBOutlet UIView *viewNavbar;
@property (weak, nonatomic) IBOutlet UISwitch *switchShowBar;
@property (weak, nonatomic) IBOutlet UIWebView *webViewPage;

- (IBAction)actionAddFavorite:(id)sender;
- (IBAction)actionOpenUrl:(id)sender;
- (IBAction)changeHideBar:(id)sender;

@end

