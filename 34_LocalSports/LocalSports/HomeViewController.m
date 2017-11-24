#import "HomeViewController.h"
#import "Constants.h"

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
                    NSLog(@"array: %@", arrayTowns);
                    [self.townsTableView reloadData];
                });
            } else {
                NSLog(@"status: %ld", (long)httpResponse.statusCode);
            }
        }
    }];
    // 4. throw task
    [task resume];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

@end
