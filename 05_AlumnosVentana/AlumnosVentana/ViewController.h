//
//  ViewController.h
//  AlumnosVentana
//
//  Created by cice on 27/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Student.h"

@interface ViewController : UIViewController

{
    Student * student;
}

@property(nonatomic, retain) IBOutlet UITextField *tfNombre;
@property(nonatomic, retain) IBOutlet UITextField *tfEdad;
@property(nonatomic, retain) IBOutlet UITextField *tfMark;
@property(nonatomic, retain) IBOutlet UISwitch *switchPractic;
@property(nonatomic, retain) IBOutlet UITextView *results;
@property(nonatomic, retain) IBOutlet UIImageView *imageResult;

-(IBAction)addStudent:(id)sender;
-(IBAction)addResult:(id)sender;
-(IBAction)showResults:(id)sender;
@end

