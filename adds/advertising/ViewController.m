//
//  ViewController.m
//  adds
//
//  Created by cice on 29/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    
    //cuando se clica en el banner, quien se encarga de navegar.
    self.bannerView.rootViewController = self;
    //para controlar el flujo del banner, podemos ser los delegados.
    self.bannerView.delegate = self;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
