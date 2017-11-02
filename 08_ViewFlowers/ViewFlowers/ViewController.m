//
//  ViewController.m
//  ViewFlowers
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
    [self getFlower:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark Acciones del view controller

- (IBAction)showHideDetails:(id)sender {
    
    if ([self.switchDetails isOn]) {
        self.viewDetails.hidden = false;
    } else {
        self.viewDetails.hidden = true;
    }
    

}

- (IBAction)getFlower:(id)sender {
    NSString * valorColor = [self.selectColor titleForSegmentAtIndex: self.selectColor.selectedSegmentIndex];
    
    int numRandom = random()%10000;
    
    NSString *stringFlower = [NSString stringWithFormat:@"http://www.floraphotographs.com/showrandomiphone.php?color=%@&session=%i", valorColor, numRandom];
    NSString *stringFlowerDetails = [NSString stringWithFormat:@"http://www.floraphotographs.com/showrandomiphone.php?session=%i", numRandom];
    
    NSURL *urlFlower = [NSURL URLWithString:stringFlower];
    NSURL *urlFlowerDetails = [NSURL URLWithString:stringFlowerDetails];
    
    NSURLRequest *requestFlower = [NSURLRequest requestWithURL:urlFlower];
    NSURLRequest *requestFlowerDetails = [NSURLRequest requestWithURL:urlFlowerDetails];
    [self.viewFlower loadRequest:requestFlower];
    [self.viewDetails loadRequest:requestFlowerDetails];

}
@end
