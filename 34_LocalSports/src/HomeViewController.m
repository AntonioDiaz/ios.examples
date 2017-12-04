#import "HomeViewController.h"
#import "Utils.h"
#import "SportsViewController.h"
#import "TownsTableViewCell.h"

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"device directory: %@", documentsDirectoryPath);
    self.navigationItem.title = [NSString stringWithFormat: NSLocalizedString(@"HOME_TITLE", nil), APP_NAME];
}

-(void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *townSelectedStr = [userDefaults objectForKey:PREF_TOWN_NAME];
    if (townSelectedStr.length > 0) {
         self.navigationItem.title = @"";
        [self performSegueWithIdentifier:@"segueSports" sender:self];
    } else {
        self.navigationItem.title = [NSString stringWithFormat: NSLocalizedString(@"HOME_TITLE", nil), APP_NAME];
        //check for internet conection.
        if ([Utils noTengoInterne]) {
            [Utils showAlert:NSLocalizedString(@"HOME_INTERNET_REQUIRED", nil)];
        } else {
            NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config];
            NSURL *url = [NSURL URLWithString:URL_TOWNS];
            NSURLSessionTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error) {
                    NSLog(@"Error on task: %@", error.description);
                } else {
                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                    if (httpResponse.statusCode == 200) {
                        NSError *jsonError = nil;
                        arrayTowns = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [self.townsTableView reloadData];
                        });
                    } else {
                        NSLog(@"status: %ld", (long)httpResponse.statusCode);
                    }
                }
            }];
            [task resume];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayTowns count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TownsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_town_new"];
    NSString *name = [[arrayTowns objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.labelTownName.text = name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - segue methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if ([userDefaults objectForKey:PREF_TOWN_NAME]==nil) {
        NSIndexPath *indexPath = [self.townsTableView indexPathForSelectedRow];
        NSDictionary *dictionary = [arrayTowns objectAtIndex:indexPath.row];
        NSString *townSelectedString = [dictionary objectForKey:@"name"];
        NSString *townSelectedId = [dictionary objectForKey:@"id"];
        [userDefaults setValue:townSelectedString forKey:PREF_TOWN_NAME];
        [userDefaults setValue:townSelectedId forKey:PREF_TOWN_ID];
    }
}
@end
