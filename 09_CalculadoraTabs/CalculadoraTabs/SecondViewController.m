//
//  SecondViewController.m
//  CalculadoraTabs
//
//  Created by cice on 30/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "SecondViewController.h"
#import "AppDelegate.h"
#import "ResultViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)calculateVolume:(id)sender {
    if (self.textFieldWidth.text.length!=0 && self.textFieldLength.text.length!=0 && self.textFieldHeight.text.length!=0) {
        float volume = self.textFieldLength.text.floatValue * self.textFieldWidth.text.floatValue * self.textFieldHeight.text.floatValue;
        self.labelResultVolumeCube.text = [NSString stringWithFormat:@"%1.2f", volume];
    }
    if (self.textFieldRadius.text.length!=0) {
        float volumeSphere = 4 * M_PI * pow(self.textFieldRadius.text.floatValue, 2);
        self.labelResultVolumeSphere.text = [NSString stringWithFormat:@"%1.2f", volumeSphere];
    }
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    UITabBarController *tabBar = (UITabBarController*)app.window.rootViewController;
    ResultViewController *resultViewController = [tabBar.viewControllers objectAtIndex:2];
    [resultViewController incrementCalculation];
    
}
@end
