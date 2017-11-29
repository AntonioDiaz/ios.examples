#import "AppDelegate.h"
#import "SportsViewController.h"
#import "CompetitionsTableViewController.h"
#import "CompetitionEntity+CoreDataProperties.h"

@implementation SportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    managedObjectContext = app.persistentContainer.viewContext;
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
    //todo: should clean database.
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
                NSLog(@"competition size %lu", (unsigned long)jsonResults.count);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //first remove all competitions.
                    [Utils deleteAllEntities:COMPETITION_ENTITY withContext:managedObjectContext];
                   for (NSDictionary *competition in jsonResults) {
                       [self insertCompetition:competition];
                    }
                    [self enableSportButtons];
                });
            } else {
                NSLog(@"status: %ld", httpResponse.statusCode);
            }
        }
    }];
    [task resume];
}

//todo move this method to database utils class
-(void) insertCompetition:(NSDictionary *) dictionaryCompetition {
    CompetitionEntity *competitionEntity =  [NSEntityDescription
                                             insertNewObjectForEntityForName:COMPETITION_ENTITY
                                             inManagedObjectContext:managedObjectContext];
    NSDictionary *dictionaryCategory = [dictionaryCompetition objectForKey:@"categoryEntity"];
    NSDictionary *dictionarySport = [dictionaryCompetition objectForKey:@"sportEntity"];
    competitionEntity.category = [dictionaryCategory objectForKey:@"name"];
    competitionEntity.categoryOrder = [[dictionaryCategory objectForKey:@"order"] integerValue];
    competitionEntity.idCompetitionServer = [[dictionaryCompetition objectForKey:@"id"] doubleValue];
    //competitionEntity.lastUpdateApp = [dictionaryCompetition objectForKey:@"lastPublished"];
    //competitionEntity.lastUpdateServer = [dictionaryCompetition objectForKey:@"lastPublished"];
    competitionEntity.name = [dictionaryCompetition objectForKey:@"name"];
    competitionEntity.sport = [dictionarySport objectForKey:@"tag"];
    NSError *error = nil;
    if(![managedObjectContext save:&error]){
        NSLog(@"Error on insert -->%@", error.localizedDescription);
    } else {
        NSLog(@"Insert done %@ - %@", competitionEntity.name, competitionEntity.sport);
    }
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    CompetitionsTableViewController *viewController = (CompetitionsTableViewController *) segue.destinationViewController;
    viewController.sportSelected = sportSelected;
}

#pragma mark - Actions
- (IBAction)actionOpenSport:(id)sender {
    UIButton *clickedButton = (UIButton *) sender;
    sportSelected = clickedButton.tag;
    [self performSegueWithIdentifier:@"idShowCompetitions" sender:nil];
}

- (IBAction)actionFavorites:(id)sender {
    NSString *alertTitle = @"favorites";
    NSString *alertDesc = @"comming soon";
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle
                message:alertDesc delegate:self cancelButtonTitle:@"Accept"
                otherButtonTitles: nil];
    [alertView show];
}
@end
