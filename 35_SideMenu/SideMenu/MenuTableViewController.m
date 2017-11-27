#import "MenuTableViewController.h"

@implementation MenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //load arrayitems.
    arrayMenuItems = [[NSArray alloc] initWithObjects:@"cell_menu", @"cell_news", @"cell_map", @"cell_image" , nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayMenuItems count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *idCell = [arrayMenuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idCell forIndexPath:indexPath];
    return cell;
}

@end
