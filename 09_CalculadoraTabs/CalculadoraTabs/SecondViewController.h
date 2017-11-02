//
//  SecondViewController.h
//  CalculadoraTabs
//
//  Created by cice on 30/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldWidth;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLength;
@property (weak, nonatomic) IBOutlet UITextField *textFieldHeight;
@property (weak, nonatomic) IBOutlet UILabel *labelResultVolumeCube;
@property (weak, nonatomic) IBOutlet UITextField *textFieldRadius;
@property (weak, nonatomic) IBOutlet UILabel *labelResultVolumeSphere;
- (IBAction)calculateVolume:(id)sender;


@end

