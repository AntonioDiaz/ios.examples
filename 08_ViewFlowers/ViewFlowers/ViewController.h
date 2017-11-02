//
//  ViewController.h
//  ViewFlowers
//
//  Created by cice on 30/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *selectColor;
@property (weak, nonatomic) IBOutlet UISwitch *switchDetails;
@property (weak, nonatomic) IBOutlet UIWebView *viewFlower;
@property (weak, nonatomic) IBOutlet UIWebView *viewDetails;

- (IBAction)showHideDetails:(id)sender;
- (IBAction)getFlower:(id)sender;



@end

