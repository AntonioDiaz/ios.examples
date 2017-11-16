//
//  ViewController.h
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nombre;
@property (weak, nonatomic) IBOutlet UITextField *imagen;

- (IBAction)guardar:(id)sender;


@end

