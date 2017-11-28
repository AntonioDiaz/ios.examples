#import "SportsViewController.h"
#import "CompetitionsViewController.h"

@implementation SportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *townSelected = [userDefaults objectForKey:PREF_TOWN_NAME];
    NSString *idTownSelected = [userDefaults objectForKey:PREF_TOWN_ID];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ - %@", APP_NAME, townSelected];
    [self initSportButton:self.buttonFootball];
    [self initSportButton:self.buttonBasketball];
    [self initSportButton:self.buttonHandball];
    [self initSportButton:self.buttonVolleyball];
    [self initSportButton:self.buttonHockey];
    [self initSportButton:self.buttonFavorites];
    [self loadCompetitions:idTownSelected];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods
-(void) enableSportButtons {
    self.buttonFootball.enabled = true;
    self.buttonBasketball.enabled = true;
    self.buttonVolleyball.enabled = true;
    self.buttonHandball.enabled = true;
    self.buttonHockey.enabled = true;
    self.buttonFavorites.enabled = true;
}

-(void) initSportButton:(UIButton*)button {
    [button setContentMode:UIViewContentModeCenter];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    button.enabled = false;
}

-(void) loadCompetitions:(NSString *) idTown {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config];
    NSString *strUrlCompetitions = [NSString stringWithFormat:URL_COMPETITIONS, idTown];
    NSURL *url = [NSURL URLWithString:strUrlCompetitions];
    NSURLSessionTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error on task: %@", error.description);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (httpResponse.statusCode == 200) {
                NSError *jsonError = nil;
                NSArray *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"results -->%d", jsonResults.count);
                    [self enableSportButtons];
                });
            } else {
                NSLog(@"status: %ld", httpResponse.statusCode);
            }
        }
    }];
    [task resume];
}


#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    CompetitionsViewController *competitionsViewController = (CompetitionsViewController *) segue.destinationViewController;
    competitionsViewController.sportSelected = sportSelected;
}

#pragma mark - Actions
- (IBAction)actionOpenSport:(id)sender {
    UIButton *clickedButton = (UIButton *) sender;
    sportSelected = clickedButton.tag;
    [self performSegueWithIdentifier:@"idShowCompetitions" sender:nil];
}
@end
