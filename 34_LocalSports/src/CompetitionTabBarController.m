#import "CompetitionTabBarController.h"
#import "MatchEntity+CoreDataProperties.h"
#import "ClassificationEntity+CoreDataProperties.h"
#import "SportCourtEntity+CoreDataProperties.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "UtilsDataBase.h"
#import "CalendarTableViewController.h"
#import "ClassificationTableViewController.h"

@implementation CompetitionTabBarController

@synthesize competitionEntity;

- (void)viewDidLoad {
    [super viewDidLoad];
    //show interstitial
    self.navigationItem.title = [NSString stringWithFormat:@"%@", self.competitionEntity.name];
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    managedObjectContext = app.persistentContainer.viewContext;
    //load competitions details on DB.
    UITabBarItem *tabBarItemCalendar = [self.tabBar.items objectAtIndex:0];
    UIImage *imageCalendar = [UIImage imageNamed:@"calendar"];
    imageCalendar = [self imageWithImage:imageCalendar scaledToSize:CGSizeMake(30, 30)];
    [tabBarItemCalendar setImage:imageCalendar];
    UITabBarItem *tabBarItemClassification = [self.tabBar.items objectAtIndex:1];
    UIImage *imageClassification = [UIImage imageNamed:@"classification"];
    imageClassification = [self imageWithImage:imageClassification scaledToSize:CGSizeMake(30, 30)];
    [tabBarItemClassification setImage:imageClassification];
    NSString *idCompetitionServer = [NSString stringWithFormat: @"%f", self.competitionEntity.idCompetitionServer];
    if ([Utils noTengoInterne]) {
        [self reloadTabsData];
    } else {
        [self loadCompetitionDetails:idCompetitionServer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - navigation
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - private methods

- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/** Load details (matches and classification) from server and update tables in DB. */
-(void) loadCompetitionDetails:(NSString *) idCompetition {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config];
    NSString *strUrlCompetitions = [NSString stringWithFormat:URL_COMPETITION_DETAILS, idCompetition];
    NSURL *url = [NSURL URLWithString:strUrlCompetitions];
    NSURLSessionTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error on task: %@", error.description);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (httpResponse.statusCode == 200) {
                NSError *jsonError = nil;
                NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                NSArray *arrayMatches = [jsonResults objectForKey:@"matches"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [UtilsDataBase deleteMatches:competitionEntity];
                    [UtilsDataBase deleteClassification:competitionEntity];
                    [UtilsDataBase deleteAllEntities:COURT_ENTITY];
                    for (NSDictionary *matchDictionary in arrayMatches) {
                        [UtilsDataBase insertMatch: matchDictionary withEntity:self.competitionEntity];
                    }
                    NSArray *arrayClassification = [jsonResults objectForKey:@"classification"];
                    for (NSDictionary *classification in arrayClassification) {
                        [UtilsDataBase insertClassification: classification withEntity:self.competitionEntity];
                    }
                    [self reloadTabsData];
                });
            } else {
                NSLog(@"status: %d", (int)httpResponse.statusCode);
            }
        }
    }];
    [task resume];
}

-(void) reloadTabsData {
    CalendarTableViewController *calendarTableViewController = self.viewControllers[0];
    [calendarTableViewController reloadDataTable:self.competitionEntity];
    ClassificationTableViewController *classificationTableViewController = self.viewControllers[1];
    [classificationTableViewController reloadDataTable:self.competitionEntity];
}
@end
