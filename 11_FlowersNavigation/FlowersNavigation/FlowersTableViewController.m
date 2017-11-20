#import "FlowersTableViewController.h"
#import "CellRedTableViewCell.h"
#import "CellBlueTableViewCell.h"
#import "ViewController.h"

#define FLOWERS_RED @"flowers_red"
#define FLOWERS_BLUE @"flowers_blue"
#define KEY_TITLE @"key_title"
#define KEY_URL @"key_url"
#define KEY_IMAGE @"key_image"

@implementation FlowersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //Title with text.
    self.title = @"Flower details";
    //Title with images.
    /*
     UIImage *image = [UIImage imageNamed:@"list"];
     UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
     self.navigationItem.titleView = imageView;
    */
    self.navigationItem.title = @"Flowers List";
    //add buttons on the top.
    UIBarButtonItem *playBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:nil];
    UIBarButtonItem *stopBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:nil];
    NSArray *actions = [[NSArray alloc] initWithObjects:playBarButtonItem, stopBarButtonItem ,nil];
    self.navigationItem.rightBarButtonItems = actions;
    //sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)

    //add new button to navigation bar.
    UIBarButtonItem *itemAlert = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showAlert:)];
    self.navigationItem.leftBarButtonItem = itemAlert;
    
    flowersDataSource = [self initializeDataSource];
    indexArray = [[flowersDataSource allKeys] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
-(NSArray *) sectionIndexTitlesForTableView:(UITableView *) tableView {
    return indexArray;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [[flowersDataSource objectForKey:FLOWERS_RED] count];
        case 1:
            return [[flowersDataSource objectForKey:FLOWERS_BLUE] count];
        default:
            return 0;
    }
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Red Flowers";
        case 1:
            return @"Blue Flowers";
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
     UITableViewCell *cell;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
     cell.textLabel.text = [flowerDictionary objectForKey:KEY_TITLE];
     cell.detailTextLabel.text = [flowerDictionary objectForKey:KEY_IMAGE];
     cell.imageView.image = [UIImage imageNamed:[flowerDictionary objectForKey:KEY_IMAGE]];
     */
    NSDictionary *flowerDictionary = [self flowerName:indexPath.section withIndex:indexPath.row];
    if(indexPath.section == 0) {
        CellRedTableViewCell *cellRed = (CellRedTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"redFlowerCell" forIndexPath:indexPath];
        cellRed.flowerName.text = [flowerDictionary objectForKey:KEY_TITLE];
        cellRed.flowerImage.image = [UIImage imageNamed:[flowerDictionary objectForKey:KEY_IMAGE]];
        cellRed.contentView.backgroundColor = [UIColor cyanColor];
        return cellRed;
    } else {
        CellBlueTableViewCell *cellBlue = [tableView dequeueReusableCellWithIdentifier:@"blueFlowerCell" forIndexPath:indexPath];
        cellBlue.flowerName.text = [flowerDictionary objectForKey:KEY_TITLE];
        cellBlue.flowerImage.image = [UIImage imageNamed:[flowerDictionary objectForKey:KEY_IMAGE]];
        cellBlue.contentView.backgroundColor = [UIColor lightGrayColor];
        return cellBlue;
    }
}

-(NSDictionary *) flowerName:(NSInteger) section withIndex:(NSInteger)index {
    NSArray *flowersArray;
    NSDictionary *flowerDictionary;
    switch (section) {
        case 0:
            flowersArray = [flowersDataSource objectForKey:FLOWERS_RED];
            flowerDictionary = [flowersArray objectAtIndex:index];
            break;
        case 1:
            flowersArray = [flowersDataSource objectForKey:FLOWERS_BLUE];
            flowerDictionary = [flowersArray objectAtIndex:index];
            break;
        default:
            break;
    }
    return flowerDictionary;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSString *flowersKey;
        if(indexPath.section==0){
            flowersKey = FLOWERS_RED;
        } else if (indexPath.section==1) {
            flowersKey = FLOWERS_BLUE;
        }
        NSMutableArray *flowersArray = flowersArray = [flowersDataSource objectForKey:flowersKey];
        [flowersArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

#pragma mark -segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSString *idSection;
    if([segue.identifier isEqualToString:@"showRedFlowers"]) {
        idSection = FLOWERS_RED;
    } else {
        idSection = FLOWERS_BLUE;
    }
    NSMutableArray *arrayData = [flowersDataSource objectForKey:idSection];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    NSDictionary *flowerPropeties = [arrayData objectAtIndex:indexPath.row];
    ViewController *viewController = segue.destinationViewController;
    viewController.self.urlFlower = [flowerPropeties objectForKey:KEY_URL];
}

#pragma mark - Navigation
-(void)showAlert:(id)sender {
    //estructura base
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"alert controller..." message:@"set flower details" preferredStyle:UIAlertControllerStyleAlert];
    //Creamos las acciones de la alerta.
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cerrar" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"guardar" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSString *name = alertController.textFields[0].text;
        NSString *image = alertController.textFields[1].text;
        NSString *url = alertController.textFields[2].text;
        [self insertFlower: name withUrl:url withImage:image];
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:saveAction];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Flower name:";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Flower image:";
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Flower URL:";
    }];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - private methods
-(NSDictionary *) initializeDataSource {
    NSDictionary *flowerRose = [[NSDictionary alloc] initWithObjectsAndKeys:@"Rose", KEY_TITLE, @"https://en.wikipedia.org/wiki/Rose", KEY_URL, @"roja-0.jpg", KEY_IMAGE, nil];
    NSDictionary *flowerPoppy = [[NSDictionary alloc] initWithObjectsAndKeys:@"Poppy", KEY_TITLE, @"https://en.wikipedia.org/wiki/Poppy", KEY_URL, @"roja-1.jpg", KEY_IMAGE, nil];
    NSDictionary *flowerPoppy2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Poppy", KEY_TITLE, @"https://en.wikipedia.org/wiki/Poppy", KEY_URL, @"roja-2.jpg", KEY_IMAGE, nil];
    NSDictionary *flowerBlue = [[NSDictionary alloc] initWithObjectsAndKeys:@"Iris", KEY_TITLE, @"https://en.wikipedia.org/wiki/Iris", KEY_URL,
                                @"azul-0.jpg", KEY_IMAGE, nil];
    NSDictionary *flowerIris = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hyacinth flower", KEY_TITLE, @"https://en.wikipedia.org/wiki/Hyacinth_(plant)", KEY_URL, @"azul-1.jpg", KEY_IMAGE, nil];
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *redFlowers = [[NSMutableArray alloc] initWithObjects: flowerRose, flowerPoppy, flowerPoppy2, nil];
    NSMutableArray *blueFlowers = [[NSMutableArray alloc] initWithObjects: flowerBlue, flowerIris, nil];
    return [[NSDictionary alloc] initWithObjectsAndKeys:redFlowers, FLOWERS_RED, blueFlowers, FLOWERS_BLUE, nil];
}

-(void) insertFlower:(NSString*)name withUrl:(NSString*)url withImage:(NSString*)image {
    NSDictionary *flowerRose = [[NSDictionary alloc] initWithObjectsAndKeys:name, KEY_TITLE, url, KEY_URL, image, KEY_IMAGE, nil];
    [[flowersDataSource objectForKey:FLOWERS_RED] insertObject:flowerRose atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationBottom];
}

-(void)tableInsertion:(id)sender {
    [self insertFlower:@"Rose" withUrl:@"https://en.wikipedia.org/wiki/Rose" withImage:@"roja-1.jpg"];
 }

@end
