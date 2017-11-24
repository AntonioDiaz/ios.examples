#import "ProductsListTableViewController.h"
#define URL_API_PRODUCTS @"http://artdinamica.com/cice/productosByUUID.php"
#define URL_API_IMAGE @"http://artdinamica.com/cice/%@"

@implementation ProductsListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated {
    NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *bodyRequest = [NSString stringWithFormat:@"UUID=%@", deviceId];
    //request config
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //sessionConfiguration.HTTPAdditionalHeaders = dictionary.
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:URL_API_PRODUCTS];
    NSMutableURLRequest *mutableUrlRequest = [NSMutableURLRequest requestWithURL:url];
    mutableUrlRequest.HTTPMethod = @"POST";
    mutableUrlRequest.HTTPBody = [bodyRequest dataUsingEncoding:NSUTF8StringEncoding];
    
    NSURLSessionTask *sessionTask = [urlSession dataTaskWithRequest:mutableUrlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (httpResponse.statusCode == 200) {
                NSError *jsonError;
                products = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                NSLog(@"response %@", products);
                NSString *alertTitle = @"Products query";
                NSString *alertDesc = [NSString stringWithFormat:@"products query done ;-)"];
                /*
                 if (serverErrorDesc!= nil) {
                 alertTitle = @"server error";
                 alertDesc = [NSString stringWithFormat:@"Error on server"];
                 }
                 */
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:alertDesc delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles: nil];
                    [alertView show];
                    [self.tableView reloadData];
                });
            } else {
                NSLog(@"http error %@", httpResponse.description);
            }
        } else {
            NSLog(@"error in task %@", error.localizedDescription);
        }
    }];
    [sessionTask resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [products count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_product" forIndexPath:indexPath];
    
    NSDictionary *dictionaryProduct = [products objectAtIndex:indexPath.row];
    cell.textLabel.text = [dictionaryProduct objectForKey:@"nombre"];
    NSString *imageName = [dictionaryProduct objectForKey:@"imagen"];
    NSString *imageUrlStr = [NSString stringWithFormat:URL_API_IMAGE, imageName];
    //create secundary thread.
    dispatch_queue_t threadDownload =
    dispatch_queue_create("Thread_download_images", nil);
    dispatch_async(threadDownload, ^{
        NSURL *urlImage = [NSURL URLWithString:imageUrlStr];
        NSData *dataImage = [NSData dataWithContentsOfURL:urlImage];
        UIImage *image = [UIImage imageWithData:dataImage];
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = image;
            [cell setNeedsLayout];
        });
    });
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

@end
