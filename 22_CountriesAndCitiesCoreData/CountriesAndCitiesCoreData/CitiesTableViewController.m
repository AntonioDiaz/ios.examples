#import "CitiesTableViewController.h"
#import "PopOverNewCityViewController.h"
#import "AppDelegate.h"
#import "City+CoreDataProperties.h"

@implementation CitiesTableViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateArrayResults];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //add new button to navigation bar.
    UIBarButtonItem *itemAlert = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showPopoverAddCity:)];
    self.navigationItem.rightBarButtonItem = itemAlert;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [citiesArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my_cell" forIndexPath:indexPath];
    
    City *city = [citiesArray objectAtIndex:indexPath.row];
    cell.textLabel.text = city.name;
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i monumentos", [city.relationship_monument count]];
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

#pragma mark - private methods
-(void)updateArrayResults {
    
    AppDelegate *app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    
    // Consultamos a bbdd por todos los paises
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *descripcion = [NSEntityDescription entityForName:@"City" inManagedObjectContext:context];
    [request setEntity:descripcion];
    
    NSPredicate *filtro = [NSPredicate predicateWithFormat:@"pais == %@", self.country];
    [request setPredicate:filtro];
    
    NSSortDescriptor *ordenNombre = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[[NSArray alloc] initWithObjects:ordenNombre, nil]];
    
    NSError *error = nil;
    citiesArray = [[context executeFetchRequest:request error:&error] mutableCopy];
    [self.tableView reloadData];
    
}


-(void) showPopoverAddCity:(id)sender {
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    PopOverNewCityViewController *newCityFormViewController = [storyBoard instantiateViewControllerWithIdentifier:@"IdFormViewController"];
    newCityFormViewController.modalPresentationStyle = UIModalPresentationPopover;
    newCityFormViewController.country = self.country;
    
    
    //Config PopOverPresentationController
    UIPopoverPresentationController *popoverController = [newCityFormViewController popoverPresentationController];
    popoverController.delegate = self;
    popoverController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popoverController.barButtonItem = sender;
    //throw the popover
    [self presentViewController:newCityFormViewController animated:true completion:nil];
}

#pragma mark - PopoverPresentationController
-(void)popoverPresentationControllerDidDismissPopover:(UIPopoverPresentationController *)popoverPresentationController {
    PopOverNewCityViewController *form = (PopOverNewCityViewController*)popoverPresentationController.presentedViewController;
    NSLog(@"%@", form.self.textFieldName.text);
}


@end
