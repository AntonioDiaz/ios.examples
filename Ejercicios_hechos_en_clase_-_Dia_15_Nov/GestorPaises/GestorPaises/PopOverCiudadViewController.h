//
//  PopOverCiudadViewController.h
//  GestorPaises
//
//  Created by formador on 14/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pais+CoreDataClass.h"

@interface PopOverCiudadViewController : UIViewController

@property(nonatomic, retain) Pais *pais;

@property (weak, nonatomic) IBOutlet UITextField *ciudadNombre;
@property (weak, nonatomic) IBOutlet UITextField *ciudadimagen;
@property (weak, nonatomic) IBOutlet UITextField *ciudadDescripcion;
@property (weak, nonatomic) IBOutlet UITextField *monumento1Nombre;
@property (weak, nonatomic) IBOutlet UITextField *monumento1Imagen;
@property (weak, nonatomic) IBOutlet UITextField *monumento1Url;
@property (weak, nonatomic) IBOutlet UITextField *monumento1Latitud;
@property (weak, nonatomic) IBOutlet UITextField *monumento1Longitud;
@property (weak, nonatomic) IBOutlet UITextField *monumento2Nombre;
@property (weak, nonatomic) IBOutlet UITextField *monumento2Imagen;
@property (weak, nonatomic) IBOutlet UITextField *monumento2Url;
@property (weak, nonatomic) IBOutlet UITextField *monumento2Latitud;
@property (weak, nonatomic) IBOutlet UITextField *monumento2Longitud;

- (IBAction)guardarCiudad:(id)sender;

@end
