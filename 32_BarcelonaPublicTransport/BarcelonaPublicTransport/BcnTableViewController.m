#import "BcnTableViewController.h"
#import "BcnViewController.h"

#define URL_API_BCN @"http://barcelonaapi.marcpous.com/metro/stations.json"
#define APP_TITLE @"Barcelona Transport"

@implementation BcnTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = APP_TITLE;
    // 1. config NSURLSession
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //config.HTTPAdditionalHeaders = [NSDictionary alloc] initWithObjectsAndKeys:@"fkelsffeials", @"API_KEY", nil;
    // 2. init session
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config];
    NSURL *url = [NSURL URLWithString:URL_API_BCN];
    
    // 3. create task
    NSURLSessionTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //check status code.
        if (error) {
            NSLog(@"Error on task: %@", error.description);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (httpResponse.statusCode == 200) {
                NSError *jsonError = nil;
                NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                bcnArrayData = [[jsonResults objectForKey:@"data"] objectForKey:@"metro"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                });
            } else {
                NSLog(@"status: %ld", httpResponse.statusCode);
            }
        }
    }];
    // 4. throw task
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [bcnArrayData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"bcn_cell" forIndexPath:indexPath];
    NSDictionary *dictionaryStation = [bcnArrayData objectAtIndex:indexPath.row];
    cell.textLabel.text = [dictionaryStation objectForKey:@"name"];
    NSString *line = [dictionaryStation objectForKey:@"line"];
    NSString *connection = [dictionaryStation objectForKey:@"connections"];
    NSString *detail = [NSString stringWithFormat:@"Line %@ with connection %@", line, connection];
    cell.detailTextLabel.text = detail;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"idSegueOpenStationDetail"]) {
        NSIndexPath *indexSelected = [self.tableView indexPathForSelectedRow];
        NSDictionary *selectedCell = [bcnArrayData objectAtIndex:indexSelected.row];
        
        BcnViewController *bcnViewController = segue.destinationViewController;
        bcnViewController.idMetroStation = [selectedCell objectForKey:@"id"];
    }
    
    

}


@end
