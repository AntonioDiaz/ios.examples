//
//  FirstViewController.m
//  CalculadoraTabs
//
//  Created by cice on 30/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "ResultViewController.h"
//#define M_PI   3.14159265358979323846264338327950288


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)calculateSurface:(id)sender {
    if (self.textFieldWidth.text.length!=0 && self.textFieldLength.text.length!=0){
        float surface = self.textFieldLength.text.floatValue * self.textFieldWidth.text.floatValue;
        self.labelResultRectangle.text = [NSString stringWithFormat:@"%1.2f", surface];
    }
    
    if (self.textFieldRadious.text.length!=0){
        //float surfaceCircle = self.textFieldRadious.text.floatValue * self.textFieldRadious.text.floatValue * M_PI;
        float surfaceCircle = powf(self.textFieldRadious.text.floatValue, 2) * M_PI;
        self.labelRestultCircle.text = [NSString stringWithFormat:@"%1.2f", surfaceCircle];
    }
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    UITabBarController *tabBar = (UITabBarController*)app.window.rootViewController;
    ResultViewController *resultViewController = [tabBar.viewControllers objectAtIndex:2];
    [resultViewController incrementCalculation];
}
@end
