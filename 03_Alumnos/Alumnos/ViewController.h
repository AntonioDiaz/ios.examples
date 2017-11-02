//
//  ViewController.h
//  Alumnos
//
//  Created by cice on 25/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, retain) IBOutlet UIButton *buttonLogin;
@property(nonatomic, retain) IBOutlet UILabel *etiqueta;
-(IBAction)clickLogin:(id)sender;

@end

