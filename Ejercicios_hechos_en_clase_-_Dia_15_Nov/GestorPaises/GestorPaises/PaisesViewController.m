//
//  PaisesViewController.m
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import "PaisesViewController.h"
#import "AppDelegate.h"
#import "Pais+CoreDataClass.h"
#import "CiudadesViewController.h"

@interface PaisesViewController ()

@end

@implementation PaisesViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.contexto = app.persistentContainer.viewContext;
    
    // Consultamos a bbdd por todos los paises
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *descripcion = [NSEntityDescription entityForName:@"Pais" inManagedObjectContext:self.contexto];
    [request setEntity:descripcion];
    
    NSSortDescriptor *ordenNombre = [[NSSortDescriptor alloc] initWithKey:@"nombre" ascending:YES];
    [request setSortDescriptors:[[NSArray alloc] initWithObjects:ordenNombre, nil]];
    
    NSError *error = nil;
    resultados = [[self.contexto executeFetchRequest:request error:&error] mutableCopy];
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [resultados count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Celda" forIndexPath:indexPath];
    
    Pais *pais = [resultados objectAtIndex:indexPath.row];
    cell.textLabel.text = pais.nombre;
    
    
    // Numero de ciudades
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i ciudades", [pais.ciudades count]];
    
    // Cargamos la imagen de portada del pais.
    NSString * documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *archivoFinal = [NSString stringWithFormat:@"%@/%@.jpg", documentsDirectoryPath, pais.nombre];
    cell.imageView.image = [UIImage imageWithContentsOfFile:archivoFinal];
    
    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        // Actualizar bbdd
        Pais *paisBorrado = [resultados objectAtIndex:indexPath.row];
        [self.contexto deleteObject:paisBorrado];
        
        // Actualizar array resultados
        [resultados removeObjectAtIndex:indexPath.row];
        
        NSError *error = nil;
        if( ![self.contexto save:&error] ) {
            NSLog(@"Error al borrar objeto");
        }
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


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


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if([segue.identifier isEqualToString:@"showCiudades"] ) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Pais *paisSeleccionado = [resultados objectAtIndex:indexPath.row];
        
        CiudadesViewController *ciudades = (CiudadesViewController*)segue.destinationViewController;
        ciudades.pais = paisSeleccionado;
    }
    
}


@end
