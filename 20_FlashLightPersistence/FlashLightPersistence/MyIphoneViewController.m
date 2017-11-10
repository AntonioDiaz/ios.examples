//
//  MyIphoneViewController.m
//  FlashLightPersistence
//
//  Created by cice on 10/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "MyIphoneViewController.h"

@interface MyIphoneViewController ()

@end

@implementation MyIphoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSLog(@"name --> %@", [userDefaults stringForKey:@"name_preference"]);
    self.labelName.text = [userDefaults stringForKey:@"name_preference"];
    self.labelEmail.text = [userDefaults stringForKey:@"email_preference"];
    self.labelPhone.text = [userDefaults stringForKey:@"phone_preference"];
    NSString *imageStr = [userDefaults stringForKey:@"image_preference"];
    self.imageViewProfile.image = [UIImage imageNamed:[imageStr stringByAppendingString:@".jpg"]];
    
    
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

@end
