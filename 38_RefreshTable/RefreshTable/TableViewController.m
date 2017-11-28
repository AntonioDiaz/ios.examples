#import "TableViewController.h"

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    arrayItems = [[NSMutableArray alloc]init];
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([arrayItems count]==0) {
        //
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        label.text = @"no data yet.";
        label.textColor = [UIColor redColor];
        label.numberOfLines = 1;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
        self.tableView.backgroundView = label;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return 0;
    } else {
        self.tableView.backgroundView  = nil;
        self.tableView.separatorStyle = UITableViewCellStyleDefault;
        return [arrayItems count];
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my_cell" forIndexPath:indexPath];
    cell.textLabel.text = [arrayItems objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark - private methods
-(void) reloadData {
    NSLog(@"reloading");
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM d, HH:mm"];
    NSString *dateStr = [dateFormat stringFromDate:currentDate];
    [arrayItems insertObject:dateStr atIndex:0];
    [self.tableView reloadData];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:
                                          [UIColor whiteColor],  NSForegroundColorAttributeName,
                                          nil];
    NSAttributedString *titleWithStyles = [[NSAttributedString alloc] initWithString:dateStr attributes: attributesDictionary];
    [self.refreshControl endRefreshing];
 }
@end
