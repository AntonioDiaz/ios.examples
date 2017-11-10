//
//  ViewController.m
//  FlashLightPersistence
//
//  Created by cice on 9/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "FlashLightViewController.h"

#define ON_OFF @"ON_OFF";
#define ALPHA @"ALPHA";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sliderLight.value = [userDefaults floatForKey:@"ALPHA"];
    self.switchLight.on = [userDefaults boolForKey:@"ON_OFF"];
    [self actionChangeLight:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)savePreferences:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:[_switchLight isOn] forKey: @"onoff"];
    [userDefaults setBool:[_sliderLight value] forKey: @"alpha"];
    [userDefaults synchronize];
    
}

- (IBAction)actionChangeLight:(id)sender {
    
    if ([_switchLight isOn]) {
        _viewLight.alpha = _sliderLight.value;
    } else {
        _viewLight.alpha = 0.0;
    }
    /*
     if ([self.switchLight isOn]) {
     self.sliderLight.alpha = self.sliderLight.value;
     } else {
     self.sliderLight.alpha = 0.0;
     }
     */
}
@end
