//
//  ViewController.h
//  RabitRunner
//
//  Created by cice on 30/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, retain) IBOutlet UIImageView *imageRabit;

@property(nonatomic, retain) IBOutlet UISlider *sliderSpeed;
@property(nonatomic, retain) IBOutlet UILabel *textSpeed;
@property(nonatomic, retain) IBOutlet UIButton *runRabbitButton;

-(IBAction)changeSpeed:(id)sender;
-(IBAction)stopRabbit:(id)sender;

@end

