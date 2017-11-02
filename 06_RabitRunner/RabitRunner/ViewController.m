//
//  ViewController.m
//  RabitRunner
//
//  Created by cice on 30/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *imagesArray = [[NSArray alloc] initWithObjects:
                            [UIImage imageNamed:@"frame-2.png"],
                            [UIImage imageNamed:@"frame-3.png"],
                            [UIImage imageNamed:@"frame-4.png"],
                            [UIImage imageNamed:@"frame-5.png"],
                            [UIImage imageNamed:@"frame-6.png"],
                            [UIImage imageNamed:@"frame-7.png"],
                            [UIImage imageNamed:@"frame-8.png"],
                            [UIImage imageNamed:@"frame-9.png"],
                            [UIImage imageNamed:@"frame-10.png"],
                            [UIImage imageNamed:@"frame-11.png"],
                            [UIImage imageNamed:@"frame-12.png"],
                            [UIImage imageNamed:@"frame-13.png"],
                            [UIImage imageNamed:@"frame-14.png"],
                            [UIImage imageNamed:@"frame-15.png"],
                            [UIImage imageNamed:@"frame-16.png"],
                            [UIImage imageNamed:@"frame-17.png"],
                            [UIImage imageNamed:@"frame-18.png"],
                            [UIImage imageNamed:@"frame-19.png"],
                            [UIImage imageNamed:@"frame-20 .png"],
                            nil];
    self.imageRabit.animationImages = imagesArray;
    self.imageRabit.animationDuration = 5;
    [self.runRabbitButton setTitle:@"run rabbit!!" forState:UIControlStateNormal];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)changeSpeed:(id)sender {
    NSLog(@"sliderSpeed %f", self.sliderSpeed.value);
    float speed = 10 * self.sliderSpeed.value + 0.00001;
    self.imageRabit.animationDuration = speed;
    [self.imageRabit startAnimating];
    self.textSpeed.text = [NSString stringWithFormat:@"%f seconds", speed];
    [self.runRabbitButton setTitle:@"stop rabbit!!" forState:UIControlStateNormal];
}

-(IBAction)stopRabbit:(id)sender {
    if ([self.imageRabit isAnimating]){
        [self.imageRabit stopAnimating];
        [sender setTitle:@"run rabbit!!" forState:UIControlStateNormal];
    } else {
        [self.imageRabit startAnimating];
        [sender setTitle:@"stop rabbit!!" forState:UIControlStateNormal];
    }
    self.textSpeed.text = [NSString stringWithFormat:@"%f seconds",  self.imageRabit.animationDuration];

}





@end
