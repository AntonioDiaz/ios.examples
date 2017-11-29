#import "CalendarTableViewController.h"
#import "MatchEntity+CoreDataProperties.h"
#import "MatchDetailTableViewCell.h"
#import "Utils.h"

@implementation CalendarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sectionsExpanded = [[NSMutableIndexSet alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self calculateNumOfWeeks];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     if ([sectionsExpanded containsIndex:section]) {
         return numMatchesEachWeek + 1;
     } else {
         return 1;
     }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    //MatchEntity *matchEntity = [arrayMatches objectAtIndex:indexPath.row];
    //cell.textLabel.text = [NSString stringWithFormat:@"%d - %@ vs %@", matchEntity.week, matchEntity.teamLocal, matchEntity.teamVisitor];
    //if ([self tableView:tableView canCollpseSection:indexPath.section]) {
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_calendar" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"Week %d", (int)indexPath.section + 1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        MatchDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_calendar_detail" forIndexPath:indexPath];
        int indexInArray = ((int)indexPath.row - 1) + (int)indexPath.section * numMatchesEachWeek;
        MatchEntity *matchEntity = [arrayMatches objectAtIndex:indexInArray];
        cell.labelLocal.text = matchEntity.teamLocal;
        cell.labelVisitor.text = matchEntity.teamVisitor;
        cell.labelScore.text = [NSString stringWithFormat:@"%d - %d", matchEntity.scoreLocal, matchEntity.scoreVisitor];
        return cell;
    }
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        //unselect cell.
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        NSInteger section = indexPath.section;
        NSMutableArray *mutableArrayCells = [[NSMutableArray alloc] init];
        for (int i=1; i<=numMatchesEachWeek; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [mutableArrayCells addObject:indexPath];
        }
        if ([sectionsExpanded containsIndex:section]) {
            [sectionsExpanded removeIndex:section];
            [tableView deleteRowsAtIndexPaths:mutableArrayCells withRowAnimation:UITableViewRowAnimationTop];
        } else {
            [sectionsExpanded addIndex:section];
            [tableView insertRowsAtIndexPaths:mutableArrayCells withRowAnimation:UITableViewRowAnimationTop];
        }
    }

}

#pragma mark - private methods
-(void) reloadDataTable {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:MATCH_ENTITY inManagedObjectContext:context];
    [request setEntity:description];
    NSError *error;
    arrayMatches = [context executeFetchRequest:request error:&error];
    numOfWeeks = [self calculateNumOfWeeks];
    numMatchesEachWeek = (int)arrayMatches.count / numOfWeeks;
    [self.tableView reloadData];
}

-(int) calculateNumOfWeeks {
    int maxWeek = 0;
    for (MatchEntity* matchEntity in arrayMatches) {
        NSLog(@"match --> %d", matchEntity.week);
        if (matchEntity.week>maxWeek) {
            maxWeek = matchEntity.week;
        }
    }
    return maxWeek;
}

@end
