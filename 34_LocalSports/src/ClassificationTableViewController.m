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
    return arrayClassification.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_classification" forIndexPath:indexPath];
    //TODO: add fields: matches played, won, lost....
    if (indexPath.row == 0) {
        cell.textLabel.text = NSLocalizedString(@"CLASSIFICATION_TEAM", nil);
        cell.detailTextLabel.text = @"Pt";
        cell.backgroundColor = UIColorFromRGB(0x0061a8);
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.detailTextLabel.textColor = [UIColor whiteColor];
        UIFont *currentFont = cell.textLabel.font;
        UIFont *newFont = [UIFont fontWithName:[NSString stringWithFormat:@"%@-Bold",currentFont.fontName] size:currentFont.pointSize];
        cell.textLabel.font = newFont;
        cell.detailTextLabel.font = newFont;
    } else {
        ClassificationEntity *classificationEntity = [arrayClassification objectAtIndex:indexPath.row - 1];
        cell.textLabel.text = [NSString stringWithFormat:@"%d - %@", classificationEntity.position, classificationEntity.team];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", classificationEntity.points];
    }
    return cell;
}

#pragma mark - private methods
-(void) reloadDataTable:(CompetitionEntity *) competition {
    arrayClassification = [UtilsDataBase queryClassification:competition];
    [self.tableView reloadData];
}

@end
