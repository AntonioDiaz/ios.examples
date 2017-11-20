//
//  NewCityFormViewController.h
//  CountriesAndCitiesCoreData
//
//  Created by Antonio Díaz Arroyo on 20/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface NewCityFormViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *textViewName;
- (IBAction)actionCancel:(id)sender;
- (IBAction)actionAccept:(id)sender;


@end
