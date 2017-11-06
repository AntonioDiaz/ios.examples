//
//  ViewController.m
//  DatePicker
//
//  Created by cice on 6/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionDatesGap:(id)sender {
    NSDate *dateNow = [[NSDate alloc] init];
    NSDate *dateSelected = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMMM d, YYYY hh:mm:ssa"];
    NSString *dateNowStr = [dateFormatter stringFromDate:dateNow];
    NSTimeInterval timeInterval = [dateNow timeIntervalSinceDate:dateSelected] / 86400;
    self.labelGap.text = [NSString stringWithFormat:@"gap in days between now and %@: %1.2f", dateNowStr, fabs(timeInterval)];
    
}
@end
