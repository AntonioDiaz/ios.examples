//
//  CiudadesViewController.m
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import "CiudadesViewController.h"
#import "AppDelegate.h"
#import "Ciudad+CoreDataClass.h"
#import "PopOverCiudadViewController.h"

@interface CiudadesViewController ()

@end

@implementation CiudadesViewController

-(void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    
    [self actualizarResultados];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Creamos un boton de añadir ciudades en la barra de navegación
    UIBarButtonItem *botonAnadir = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(abrirPopOver)];
    self.navigationItem.rightBarButtonItem = botonAnadir;
    
    self.title = self.pais.nombre;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [resultados count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Celda" forIndexPath:indexPath];
    
    Ciudad *ciudad = [resultados objectAtIndex:indexPath.row];
    cell.textLabel.text = ciudad.nombre;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i monumentos", [ciudad.monumentos count]];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Metodos privados
-(void)abrirPopOver {
    
    // Recuperamos una instancia del viewController de Formulario
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopOverCiudadViewController *formulario = [storyBoard instantiateViewControllerWithIdentifier:@"formularioCiudad"];
    formulario.modalPresentationStyle = UIModalPresentationPopover;
    formulario.pais = self.pais;
    
    // Configuramos un PopOverPresentationController
    UIPopoverPresentationController *popOverController = [formulario popoverPresentationController];
    popOverController.delegate = self;
    popOverController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popOverController.barButtonItem = self.navigationItem.rightBarButtonItem;
    
    // Lanzamos el popOver
    [self presentViewController:formulario animated:true completion:nil];
    
}


#pragma mark Metodos de delgado de PopOverPresentationController
-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    
    [self actualizarResultados];
    
}

-(void)actualizarResultados {
   
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.contexto = app.persistentContainer.viewContext;
    
    // Consultamos a bbdd por todos los paises
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *descripcion = [NSEntityDescription entityForName:@"Ciudad" inManagedObjectContext:self.contexto];
    [request setEntity:descripcion];
    
    NSPredicate *filtro = [NSPredicate predicateWithFormat:@"pais == %@", self.pais];
    [request setPredicate:filtro];
    
    NSSortDescriptor *ordenNombre = [[NSSortDescriptor alloc] initWithKey:@"nombre" ascending:YES];
    [request setSortDescriptors:[[NSArray alloc] initWithObjects:ordenNombre, nil]];
    
    NSError *error = nil;
    resultados = [[self.contexto executeFetchRequest:request error:&error] mutableCopy];
    
    [self.tableView reloadData];
    
}


@end
