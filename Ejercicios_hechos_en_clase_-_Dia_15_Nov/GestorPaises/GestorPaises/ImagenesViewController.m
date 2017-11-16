//
//  ImagenesViewController.m
//  GestorPaises
//
//  Created by formador on 15/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import "ImagenesViewController.h"
#import "AppDelegate.h"
#import "Monumento+CoreDataClass.h"
#import "Ciudad+CoreDataClass.h"
#import "Pais+CoreDataClass.h"

@interface ImagenesViewController ()

@end

@implementation ImagenesViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *contexto = app.persistentContainer.viewContext;
    
    // Consultamos a bbdd por todos los paises
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *descripcion = [NSEntityDescription entityForName:@"Monumento" inManagedObjectContext:contexto];
    [request setEntity:descripcion];
    
    NSSortDescriptor *ordenNombre = [[NSSortDescriptor alloc] initWithKey:@"nombre" ascending:YES];
    [request setSortDescriptors:[[NSArray alloc] initWithObjects:ordenNombre, nil]];
    
    NSError *error = nil;
    resultados = [contexto executeFetchRequest:request error:&error];
    
    // Recorremos el array dibujando UIImageView
    for(Monumento *monumento in resultados) {
        
        float xImagen = random() % (int)(self.view.frame.size.width);
        float yImagen = random() % (int)(self.view.frame.size.height);
        
        // Creamos un UIImageView
        UIImageView *vistaMonumento = [[UIImageView alloc] initWithFrame:CGRectMake(xImagen, yImagen, 100.0, 100.0)];
        
        //Asociamos el UIImageView a la vista del UIViewController
        [self.view addSubview:vistaMonumento];
        
        // Cargamos un UIImage en el UIImageView
        NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSString *archivoFinal = [NSString stringWithFormat:@"%@/%@.jpg", documentsDirectoryPath, monumento.nombre];
        vistaMonumento.image = [UIImage imageWithContentsOfFile:archivoFinal];
        vistaMonumento.userInteractionEnabled = YES;
        
        
        // Añadimos la posibilidad de arrastrar las imagenes
        UIPanGestureRecognizer *arrastrar = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(arrastrar:)];
        arrastrar.delegate = self;
        [vistaMonumento addGestureRecognizer:arrastrar];
        //añadimos doble click para sacar panel informacion
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                       initWithTarget:self action:@selector(mostrarInformacion:)];
        tap.delegate = self;
        tap.numberOfTapsRequired = 2;
        [vistaMonumento addGestureRecognizer:tap];
        
        vistaMonumento.tag = [resultados indexOfObject:monumento];
        
        //[self.imagen addGestureRecognizer:arrastrar];
        //self.imagen.image = [UIImage imageWithContentsOfFile:archivoFinal];
    }
    //Monumento *monumento = [resultados objectAtIndex:3];
   /* UIPanGestureRecognizer *arrastrarImagen = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(arrastrar:)];
    [self.vista addGestureRecognizer:arrastrarImagen];*/
    //self.imagen.image = [UIImage imageWithContentsOfFile:archivoFinal];
    //arrastrarImagen.delegate = self;
    
}

-(void) mostrarInformacion:(UITapGestureRecognizer *) gestureRecognizer {
    //recuper monumento clicado
    Monumento *monumentoSeleccionado = [resultados objectAtIndex:gestureRecognizer.view.tag];
    self.textViewMonumento.text = monumentoSeleccionado.nombre;
    self.textViewCiudad.text = monumentoSeleccionado.ciudad.nombre;
    self.textViewPais.text = monumentoSeleccionado.ciudad.pais.nombre;
    
    
    [UIView animateWithDuration:1.5 animations:^{self.vista.frame = CGRectOffset(self.vista.frame, 0.0, 149.0);}];
    [self.view bringSubviewToFront:self.vista];
}

-(void)arrastrar:(UIPanGestureRecognizer *)gestureRecognizer {
    
    CGPoint centro = [gestureRecognizer locationInView:self.view];
    gestureRecognizer.view.center = centro;
}


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

@end
