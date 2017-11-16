//
//  FirstViewController.m
//  ClicksEnPantalla
//
//  Created by formador on 14/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *clickSencillo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestionUnClick:)];
    [self.cuadrado addGestureRecognizer:clickSencillo];
    
}

-(void)gestionUnClick:(UITapGestureRecognizer*)tapGestureRecognizer {
    
    if(self.cuadrado.frame.size.width == 100.0) {
        self.cuadrado.frame = CGRectMake(self.cuadrado.frame.origin.x, self.cuadrado.frame.origin.y, 200.0, 200.0);
    } else {
        self.cuadrado.frame = CGRectMake(self.cuadrado.frame.origin.x, self.cuadrado.frame.origin.y, 100.0, 100.0);
    }
    
    // Centramos el cuadrado, con lo que dinamicamente modifica el X/Y (el ORIGIN)
    self.cuadrado.center = self.view.center;
    
}

@end
