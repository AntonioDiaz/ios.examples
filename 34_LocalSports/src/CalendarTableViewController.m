#import "CalendarTableViewController.h"
#import "MatchEntity+CoreDataProperties.h"
#import "SportCourtEntity+CoreDataProperties.h"
#import "MatchDetailTableViewCell.h"
#import "Utils.h"
#import "MatchAddEventViewController.h"


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
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_calendar" forIndexPath:indexPath];
        cell.textLabel.text = [NSString stringWithFormat:@"Week %d", (int)indexPath.section + 1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    } else {
        MatchDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_calendar_detail" forIndexPath:indexPath];
        int indexInArray = ((int)indexPath.row - 1) + (int)indexPath.section * numMatchesEachWeek;
        MatchEntity *matchEntity = [arrayMatches objectAtIndex:indexInArray];
        NSString* dateStr = [Utils formatDateDoubleToStr:matchEntity.date];
        cell.labelLocal.text = matchEntity.teamLocal;
        cell.labelVisitor.text = matchEntity.teamVisitor;
        cell.labelDate.text = dateStr;
        cell.labelCenter.text = matchEntity.court.centerName;
        cell.labelScore.text = [NSString stringWithFormat:@"%d - %d", matchEntity.scoreLocal, matchEntity.scoreVisitor];
        return cell;
    }
}

#pragma mark - table delegate
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
    } else {
        NSString *alertTitle = @"Actions with the match";
        NSString *strActionShare = @"Share match details";
        NSString *strActionAddEvent = @"Add calendar event";
        NSString *strActionSendIssue = @"Send issue";
        NSString *strActionOpenMap = @"View map";
        NSString *strActionClose = @"Close";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *actionShare = [UIAlertAction actionWithTitle:strActionShare style:UIAlertActionStyleDefault
         handler:^(UIAlertAction *action) {
             [alertController dismissViewControllerAnimated:YES completion:nil];
         }];
        [alertController addAction:actionShare];
        
        UIAlertAction *actionAddEvent = [UIAlertAction actionWithTitle:strActionAddEvent style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
              [self performSegueWithIdentifier:@"idSegueMatchAddEvent" sender:nil];
            
        }];
        [alertController addAction:actionAddEvent];
        
        UIAlertAction *actionSendIssue = [UIAlertAction actionWithTitle:strActionSendIssue style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:actionSendIssue];
        
        UIAlertAction *actionOpenMap = [UIAlertAction actionWithTitle:strActionOpenMap style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction:actionOpenMap];
        
        UIAlertAction *actionClose = [UIAlertAction actionWithTitle:strActionClose style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
             [alertController dismissViewControllerAnimated:YES completion:nil];
         }];
        [alertController addAction:actionClose];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    int indexInArray = ((int)indexPath.row - 1) + (int)indexPath.section * numMatchesEachWeek;
    MatchEntity *matchEntity = [arrayMatches objectAtIndex:indexInArray];
    if ([[segue identifier] isEqualToString:@"idSegueMatchAddEvent"]) {
        MatchAddEventViewController *matchAddEventViewController = (MatchAddEventViewController *) segue.destinationViewController;
        matchAddEventViewController.matchEntity = matchEntity;
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
        if (matchEntity.week>maxWeek) {
            maxWeek = matchEntity.week;
        }
    }
    return maxWeek;
}

@end
