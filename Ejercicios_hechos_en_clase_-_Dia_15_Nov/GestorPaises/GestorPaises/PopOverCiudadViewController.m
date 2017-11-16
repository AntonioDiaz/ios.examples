//
//  PopOverCiudadViewController.m
//  GestorPaises
//
//  Created by formador on 14/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import "PopOverCiudadViewController.h"
#import "AppDelegate.h"
#import "Ciudad+CoreDataClass.h"
#import "Monumento+CoreDataClass.h"
#import "UbicacionMonumento+CoreDataClass.h"

@interface PopOverCiudadViewController ()

@end

@implementation PopOverCiudadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)guardarCiudad:(id)sender {
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *contexto = app.persistentContainer.viewContext;
    
    // Creo ubicaciones de los monumentos
    UbicacionMonumento *ubicacion1 = [NSEntityDescription insertNewObjectForEntityForName:@"UbicacionMonumento" inManagedObjectContext:contexto];
    ubicacion1.latitud = self.monumento1Latitud.text;
    ubicacion1.longitud = self.monumento1Longitud.text;
    
    UbicacionMonumento *ubicacion2 = [NSEntityDescription insertNewObjectForEntityForName:@"UbicacionMonumento" inManagedObjectContext:contexto];
    ubicacion2.latitud = self.monumento2Latitud.text;
    ubicacion2.longitud = self.monumento2Longitud.text;
 
    // Creo Monumentos y añado las relaciones con sus ubicaciones
    Monumento *monumento1 = [NSEntityDescription insertNewObjectForEntityForName:@"Monumento" inManagedObjectContext:contexto];
    monumento1.nombre = self.monumento1Nombre.text;
    monumento1.imagen = self.monumento1Imagen.text;
    monumento1.url = self.monumento1Url.text;
    monumento1.ubicacion = ubicacion1;
    
    [self guardarImagen:monumento1.imagen imagenFinal:monumento1.nombre];
    
    
    Monumento *monumento2 = [NSEntityDescription insertNewObjectForEntityForName:@"Monumento" inManagedObjectContext:contexto];
    monumento2.nombre = self.monumento2Nombre.text;
    monumento2.imagen = self.monumento2Imagen.text;
    monumento2.url = self.monumento2Url.text;
    monumento2.ubicacion = ubicacion2;
    
    [self guardarImagen:monumento2.imagen imagenFinal:monumento2.nombre];
    
    
    Ciudad *ciudad = [NSEntityDescription insertNewObjectForEntityForName:@"Ciudad" inManagedObjectContext:contexto];
    ciudad.nombre = self.ciudadNombre.text;
    ciudad.descripcion = self.ciudadDescripcion.text;
    ciudad.imagen = self.ciudadimagen.text;
    [ciudad addMonumentosObject:monumento1];
    [ciudad addMonumentosObject:monumento2];
    ciudad.pais = self.pais;
    
    [self guardarImagen:ciudad.imagen imagenFinal:ciudad.nombre];
    
    
    
    NSError *error = nil;
    [contexto save:&error];
    
    [self dismissViewControllerAnimated:true completion:nil];
    [self.popoverPresentationController.delegate popoverPresentationControllerDidDismissPopover:self.popoverPresentationController];
    
}


#pragma mark Metodos privados

-(void)guardarImagen:(NSString*)url imagenFinal:(NSString*)nombreImagen {
    
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    // Recuperamos el archivo original en formato NSData
    NSData *datosImagen = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    // Guardamos en la ubicación final
    NSError *error = nil;
    NSString *archivoFinal = [NSString stringWithFormat:@"%@/%@.jpg", documentsDirectoryPath, nombreImagen];
    
    [datosImagen writeToFile:archivoFinal options:NSDataWritingAtomic error:&error];
    
}


@end
