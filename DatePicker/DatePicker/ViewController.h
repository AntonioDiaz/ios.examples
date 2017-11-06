//
//  ViewController.h
//  DatePicker
//
//  Created by cice on 6/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UILabel *labelGap;
- (IBAction)actionDatesGap:(id)sender;

@end

