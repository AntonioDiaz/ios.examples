//
//  ViewController.m
//  FlashLightPersistence
//
//  Created by cice on 9/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "FlashLightViewController.h"

#define KEY_ONOFF @"ON_OFF"
#define KEY_ALPHA @"ALPHA"

@interface FlashLightViewController ()

@end

@implementation FlashLightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.sliderLight.value = [userDefaults floatForKey:KEY_ALPHA];
    self.switchLight.on = [userDefaults boolForKey:KEY_ONOFF];
    [self actionChangeLight:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)savePreferences:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:[self.switchLight isOn] forKey: KEY_ONOFF];
    [userDefaults setFloat:self.sliderLight.value forKey: KEY_ALPHA];
    [userDefaults synchronize];
    
}

- (IBAction)actionChangeLight:(id)sender {
    if ([_switchLight isOn]) {
        self.viewLight.alpha = self.sliderLight.value;
    } else {
        self.viewLight.alpha = 0.0;
    }
}
@end

