#import "PopOverNewCityViewController.h"
#import "MonumentLocation+CoreDataProperties.h"
#import "Monument+CoreDataProperties.h"
#import "City+CoreDataProperties.h"
#import "AppDelegate.h"

@implementation PopOverNewCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    [self.popoverPresentationController.delegate popoverPresentationControllerDidDismissPopover:self.popoverPresentationController];
}

- (IBAction)actionAccept:(id)sender {
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    
    MonumentLocation *location1 = [NSEntityDescription insertNewObjectForEntityForName:@"MonumentLocation" inManagedObjectContext:context];
    location1.latitude = self.monument1Latitude.text;
    location1.longitude = self.monument1Longitude.text;
    
    MonumentLocation *location2 = [NSEntityDescription insertNewObjectForEntityForName:@"MonumentLocation" inManagedObjectContext:context];
    location2.latitude = self.monument2Latitude.text;
    location2.longitude = self.monument2Longitude.text;
    
    Monument *monument1 = [NSEntityDescription insertNewObjectForEntityForName:@"Monument" inManagedObjectContext:context];
    monument1.name = self.monument1Name.text;
    monument1.image = self.monument1Image.text;
    monument1.url = self.monument1Url.text;
    monument1.relationship_monument_location = location1;
    
    [self guardarImagen:monument1.image imagenFinal:monument1.name];
    
    Monument *monument2 = [NSEntityDescription insertNewObjectForEntityForName:@"Monument" inManagedObjectContext:context];
    monument2.name = self.monument2Name.text;
    monument2.image = self.monument2Image.text;
    monument2.url = self.monument2Url.text;
    monument2.relationship_monument_location = location2;
    
    [self guardarImagen:monument2.image imagenFinal:monument2.name];
    
    City *city = [NSEntityDescription insertNewObjectForEntityForName:@"City" inManagedObjectContext:context];
    city.name = self.cityName.text;
    city.desc = self.cityDescription.text;
    city.image = self.cityImage.text;
    [city addRelationship_monumentObject:monument1];
    [city addRelationship_monumentObject:monument2];
    city.relationship_country = self.country;
    [self guardarImagen:city.image imagenFinal:city.name];
    
    NSError *error = nil;
    [context save:&error];
    NSString *saveMsg = @"save done";
    if (error) {
        saveMsg = error.localizedDescription;
    }
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"save" message:saveMsg delegate:self cancelButtonTitle:@"Accept" otherButtonTitles: nil];
    [alertView show];


    
  
}

#pragma mark - UIAlertViewDelegate methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self dismissViewControllerAnimated:true completion:nil];
    [self.popoverPresentationController.delegate popoverPresentationControllerDidDismissPopover:self.popoverPresentationController];
}


#pragma mark - private methods
-(void)guardarImagen:(NSString*)url imagenFinal:(NSString*)nombreImagen {
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"directory --> %@", documentsDirectoryPath);
    // Recuperamos el archivo original en formato NSData
    NSData *datosImagen = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    // Guardamos en la ubicación final
    NSError *error = nil;
    NSString *archivoFinal = [NSString stringWithFormat:@"%@/%@.jpg", documentsDirectoryPath, nombreImagen];
    [datosImagen writeToFile:archivoFinal options:NSDataWritingAtomic error:&error];
}

@end
