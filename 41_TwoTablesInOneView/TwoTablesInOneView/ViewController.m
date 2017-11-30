#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayDays = [[NSMutableArray alloc] init];
    arrayTimes = [[NSMutableArray alloc] init];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)actionAddTime:(id)sender {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    [arrayTimes addObject:[formatter stringFromDate:date]];
    
    [self.tableViewTimes reloadData];
    
}

- (IBAction)actionAddDay:(id)sender {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    [arrayDays addObject:[formatter stringFromDate:date]];
    
    [self.tableViewDays reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.tableViewTimes) {
        return arrayTimes.count;
    } else {
        return arrayDays.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my_cell"];
    NSString *cellText;
    if (tableView == self.tableViewTimes) {
        cellText = [arrayTimes objectAtIndex:indexPath.row];
    } else {
        cellText = [arrayDays objectAtIndex:indexPath.row];
    }
    cell.textLabel.text = cellText;
    return cell;
}

@end
