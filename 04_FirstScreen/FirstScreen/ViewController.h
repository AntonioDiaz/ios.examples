//
//  ViewController.h
//  FirstScreen
//
//  Created by cice on 27/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, retain) IBOutlet UITextField *tfSitio;
@property(nonatomic, retain) IBOutlet UITextField *tfVerbo;
@property(nonatomic, retain) IBOutlet UITextField *tfNumero;

@property(nonatomic, retain) IBOutlet UITextView *tvPlantillaHistoria;
@property(nonatomic, retain) IBOutlet UITextView *tvHistoria;

-(IBAction)generaHistoria:(id)sender;


@end

