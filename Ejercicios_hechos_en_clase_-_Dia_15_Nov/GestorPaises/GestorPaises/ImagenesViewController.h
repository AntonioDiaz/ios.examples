//
//  ImagenesViewController.h
//  GestorPaises
//
//  Created by formador on 15/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagenesViewController : UIViewController <UIGestureRecognizerDelegate>
{
    NSArray *resultados;
}

@property (weak, nonatomic) IBOutlet UIView *vista;
@property (weak, nonatomic) IBOutlet UILabel *vistaMonumento;
@property (weak, nonatomic) IBOutlet UILabel *textViewMonumento;

@property (weak, nonatomic) IBOutlet UILabel *textViewCiudad;
@property (weak, nonatomic) IBOutlet UILabel *textViewPais;

@end
