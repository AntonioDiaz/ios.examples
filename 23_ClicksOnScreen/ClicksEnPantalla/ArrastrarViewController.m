//
//  ArrastrarViewController.m
//  ClicksEnPantalla
//
//  Created by formador on 15/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import "ArrastrarViewController.h"

@interface ArrastrarViewController ()

@end

@implementation ArrastrarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *reconocedorArrastrar = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moverCuadrado:)];
    [self.cuadrado addGestureRecognizer:reconocedorArrastrar];
}

-(void)moverCuadrado:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    CGPoint centro = [panGestureRecognizer locationInView:self.view];
    self.cuadrado.center = centro;
    
}

@end
