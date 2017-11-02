//
//  FirstViewController.h
//  CalculadoraTabs
//
//  Created by cice on 30/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldWidth;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLength;
@property (weak, nonatomic) IBOutlet UILabel *labelResultRectangle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldRadious;
@property (weak, nonatomic) IBOutlet UILabel *labelRestultCircle;
- (IBAction)calculateSurface:(id)sender;


@end

