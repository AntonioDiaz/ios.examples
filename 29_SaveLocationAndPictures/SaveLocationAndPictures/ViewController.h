//
//  ViewController.h
//  SaveLocationAndPictures
//
//  Created by cice on 20/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLocation;
- (IBAction)actionLibrary:(id)sender;
- (IBAction)actionCamera:(id)sender;
- (IBAction)actionSave:(id)sender;
@end

