#import "ClassificationTableViewController.h"
#import "ClassificationEntity+CoreDataProperties.h"
#import "ClassificationEntity+CoreDataClass.h"
#import "AppDelegate.h"
#import "Utils.h"

@interface ClassificationTableViewController ()

@end

@implementation ClassificationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return arrayClassification.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_classification" forIndexPath:indexPath];
    ClassificationEntity *classificationEntity = [arrayClassification objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d - %@", classificationEntity.position, classificationEntity.team];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", classificationEntity.points];
    return cell;
}

#pragma mark - private methods
-(void) reloadDataTable {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:CLASSIFICATION_ENTITY inManagedObjectContext:context];
    [request setEntity:description];
    NSError *error;
    arrayClassification = [context executeFetchRequest:request error:&error];
    [self.tableView reloadData];
}

@end
