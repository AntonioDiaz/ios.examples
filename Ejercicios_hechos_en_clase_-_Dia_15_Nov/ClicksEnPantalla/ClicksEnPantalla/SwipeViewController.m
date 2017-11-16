//
//  SwipeViewController.m
//  ClicksEnPantalla
//
//  Created by formador on 15/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import "SwipeViewController.h"

@interface SwipeViewController ()

@end

@implementation SwipeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISwipeGestureRecognizer *swipeDerecha = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deslizarDerecha:)];
    swipeDerecha.direction = UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *swipeIzquierda = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deslizarIzquierda:)];
    swipeIzquierda.direction = UISwipeGestureRecognizerDirectionLeft;
    
    // Asociamos la posibilidad de deslizar a los dos lados al cuadrado central
    [self.cuadradoRojo addGestureRecognizer:swipeIzquierda];
    [self.cuadradoRojo addGestureRecognizer:swipeDerecha];
    
    // Asociamos el gesto de deslizar a la izquierda al cuadrado de la derecha para volver a las posiciones iniciales. Y viceversa
    UISwipeGestureRecognizer *swipeDerechaVerde = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deslizarDerecha:)];
    swipeDerechaVerde.direction = UISwipeGestureRecognizerDirectionRight;
    UISwipeGestureRecognizer *swipeIzquierdaNegro = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(deslizarIzquierda:)];
    swipeIzquierdaNegro.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.cuadradoVerde addGestureRecognizer:swipeDerechaVerde];
    [self.cuadradoNegro addGestureRecognizer:swipeIzquierdaNegro];
    
    
    
}


-(void)deslizarDerecha:(UISwipeGestureRecognizer *)gestureRecognizer {
    
    // El offset podría ser dinámico, para que se ajuste al tamaño de la pantalla:
    // self.view.frame.size.width
    
    [UIView animateWithDuration:0.5 animations:^{
        self.cuadradoRojo.frame = CGRectOffset(self.cuadradoRojo.frame, 375.0, 0);
        self.cuadradoNegro.frame = CGRectOffset(self.cuadradoNegro.frame, 375.0, 0);
        self.cuadradoVerde.frame = CGRectOffset(self.cuadradoVerde.frame, 375.0, 0);
    }];
    
}

-(void)deslizarIzquierda:(UISwipeGestureRecognizer *)gestureRecognizer {
    
    [UIView animateWithDuration:0.5 animations:^{
        self.cuadradoRojo.frame = CGRectOffset(self.cuadradoRojo.frame, -375.0, 0);
        self.cuadradoNegro.frame = CGRectOffset(self.cuadradoNegro.frame, -375.0, 0);
        self.cuadradoVerde.frame = CGRectOffset(self.cuadradoVerde.frame, -375.0, 0);
    }];
}




@end
