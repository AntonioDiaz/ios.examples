//
//  SecondViewController.m
//  ClicksEnPantalla
//
//  Created by formador on 14/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *clickDoble = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestionDosClicks:)];
    
    clickDoble.numberOfTapsRequired = 2; // Numero de clicks en pantalla
    clickDoble.numberOfTouchesRequired = 1; // Numero de dedos al hacer el click
    
    [self.cuadrado addGestureRecognizer:clickDoble];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)gestionDosClicks:(UITapGestureRecognizer*)tapGestureRecognizer {
    
    if(self.cuadrado.frame.size.width == 100.0) {
        self.cuadrado.frame = CGRectMake(self.cuadrado.frame.origin.x, self.cuadrado.frame.origin.y, 200.0, 200.0);
    } else {
        self.cuadrado.frame = CGRectMake(self.cuadrado.frame.origin.x, self.cuadrado.frame.origin.y, 100.0, 100.0);
    }
    
    // Centramos el cuadrado, con lo que dinamicamente modifica el X/Y (el ORIGIN)
    self.cuadrado.center = self.view.center;
    
}

@end
