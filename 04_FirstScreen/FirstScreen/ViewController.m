//
//  ViewController.m
//  FirstScreen
//
//  Created by cice on 27/10/17.
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

#pragma mark Acciones del view Controller
-(IBAction)generaHistoria:(id)sender {
    NSString *strVerbo = self.tfVerbo.text;
    NSString *strSitio = self.tfSitio.text;
    NSString *strNumero = self.tfNumero.text;
    
    NSString *myHistory = self.tvPlantillaHistoria.text;
    myHistory = [myHistory stringByReplacingOccurrencesOfString:@"<sitio>" withString:strSitio];
    myHistory = [myHistory stringByReplacingOccurrencesOfString:@"<verbo>" withString:strVerbo];
    myHistory = [myHistory stringByReplacingOccurrencesOfString:@"<numero>" withString:strNumero];
    self.tvHistoria.text = myHistory;
    
}


@end
