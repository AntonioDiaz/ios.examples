#import "ClassificationTableViewController.h"
#import "ClassificationEntity+CoreDataProperties.h"
#import "ClassificationEntity+CoreDataClass.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "UtilsDataBase.h"

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
-(void) reloadDataTable:(CompetitionEntity *) competition {
    arrayClassification = [UtilsDataBase queryClassification:competition];
    [self.tableView reloadData];
}

@end
