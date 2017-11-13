//
//  ViewController.h
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *save;

@property (weak, nonatomic) IBOutlet UITextField *textFieldImage;
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
- (IBAction)actionSave:(id)sender;

@end

