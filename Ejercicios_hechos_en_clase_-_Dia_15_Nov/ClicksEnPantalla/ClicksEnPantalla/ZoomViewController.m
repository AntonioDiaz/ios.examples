//
//  ZoomViewController.m
//  ClicksEnPantalla
//
//  Created by formador on 15/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import "ZoomViewController.h"

@interface ZoomViewController ()

@end

@implementation ZoomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPinchGestureRecognizer *zoom = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(zoomCuadrado:)];
    [self.cuadrado addGestureRecognizer:zoom];
    
}

-(void)zoomCuadrado:(UIPinchGestureRecognizer *)gestureRecognizer {
    
    self.cuadrado.transform = CGAffineTransformScale(self.cuadrado.transform, gestureRecognizer.scale, gestureRecognizer.scale);
    
}

@end
