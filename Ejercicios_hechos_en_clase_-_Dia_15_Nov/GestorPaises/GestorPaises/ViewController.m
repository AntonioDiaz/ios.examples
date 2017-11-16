//
//  ViewController.m
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Pais+CoreDataClass.h"

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


- (IBAction)guardar:(id)sender {

    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *contexto = app.persistentContainer.viewContext;
    
    // Consultamos a bbdd si existe este pais
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *descripcion = [NSEntityDescription entityForName:@"Pais" inManagedObjectContext:contexto];
    [request setEntity:descripcion];
    
    // Filtamos por el nombre del pais
    NSPredicate *filtro = [NSPredicate predicateWithFormat:@"nombre == %@", self.nombre.text];
    [request setPredicate:filtro];
    
    NSError *error = nil;
    NSArray *resultados = [contexto executeFetchRequest:request error:&error];
    
    if(resultados != nil && [resultados count] > 0) {
        NSLog(@"Ya existe el pais %@", self.nombre.text);
        
        // Actualizamos la bbdd con la nueva imagen
        Pais *paisAModificar = [resultados objectAtIndex:0];
        paisAModificar.imagen = self.imagen.text;
        
    } else {
       
        // Insertamos un nuevo pais en la bbdd
        Pais *paisNuevo = [NSEntityDescription insertNewObjectForEntityForName:@"Pais" inManagedObjectContext:contexto];
        
        paisNuevo.imagen = self.imagen.text;
        paisNuevo.nombre = self.nombre.text;
        
    }
    
    error = nil;
    if( ![contexto save:&error] ) {
        
    } else {
        
        [self guardarImagen:self.imagen.text imagenFinal:self.nombre.text];
        
    }
    
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
