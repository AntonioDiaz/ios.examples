#import "EventTableViewController.h"
#define CELL_ID @"my_cell"


@interface EventTableViewController ()

@end

@implementation EventTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    eventStore = [[EKEventStore alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated {
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            //alertView must run on main thread.
            [self showAlert:@"Event" withSubtitle:@"access needed"];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                NSCalendar *calendar = [NSCalendar currentCalendar];
                NSDate *dateToday = [NSDate date];
                NSDateComponents *dateComponentsEnd = [[NSDateComponents alloc] init];
                dateComponentsEnd.day = 7;
                NSDate *dateEnd = [calendar dateByAddingComponents:dateComponentsEnd toDate:dateToday options:0];
                NSPredicate *predicate = [eventStore predicateForEventsWithStartDate:dateToday endDate:dateEnd calendars:nil];
                arrayEvents = [eventStore eventsMatchingPredicate:predicate];
                for (EKEvent *event in arrayEvents) {
                    NSLog(@"Event %@", event.title);
                }
                [self.tableView reloadData];
            });
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayEvents count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_ID forIndexPath:indexPath];
    EKEvent *event = [arrayEvents objectAtIndex:indexPath.row];
    cell.textLabel.text = event.title;
    NSDateFormatter *dateFormate = [[NSDateFormatter alloc] init];
    [dateFormate setDateFormat:@"yyyy/MM/dd HH:mm"];
    cell.detailTextLabel.text = [dateFormate stringFromDate:event.startDate];
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
-(void) showAlert:(NSString *)title withSubtitle:(NSString *)subtitle {
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:subtitle delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alertView show];
    });
}

@end
