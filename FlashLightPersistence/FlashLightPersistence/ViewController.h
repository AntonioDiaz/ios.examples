//
//  ViewController.h
//  FlashLightPersistence
//
//  Created by cice on 9/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewLight;
@property (weak, nonatomic) IBOutlet UISwitch *switchLight;
@property (weak, nonatomic) IBOutlet UISlider *sliderLight;
- (IBAction)savePreferences:(id)sender;
- (IBAction)actionChangeLight:(id)sender;

@end

