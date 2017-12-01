#import "CompetitionTabBarController.h"
#import "MatchEntity+CoreDataProperties.h"
#import "ClassificationEntity+CoreDataProperties.h"
#import "SportCourtEntity+CoreDataProperties.h"
#import "AppDelegate.h"
#import "Utils.h"
#import "CalendarTableViewController.h"
#import "ClassificationTableViewController.h"

@implementation CompetitionTabBarController

@synthesize competitionEntity;

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = [NSString stringWithFormat:@"%@ - %@", self.competitionEntity.category, self.competitionEntity.name];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@", self.competitionEntity.name];
    
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    managedObjectContext = app.persistentContainer.viewContext;
    
    //load competitions details on DB.
    NSString *idCompetitionServer = [NSString stringWithFormat: @"%f", self.competitionEntity.idCompetitionServer];

    UITabBarItem *tabBarItemCalendar = [self.tabBar.items objectAtIndex:0];
    UIImage *imageCalendar = [UIImage imageNamed:@"calendar"];
    imageCalendar = [self imageWithImage:imageCalendar scaledToSize:CGSizeMake(30, 30)];
    [tabBarItemCalendar setImage:imageCalendar];
    
    
    UITabBarItem *tabBarItemClassification = [self.tabBar.items objectAtIndex:1];
    UIImage *imageClassification = [UIImage imageNamed:@"classification"];
    imageClassification = [self imageWithImage:imageClassification scaledToSize:CGSizeMake(30, 30)];
    [tabBarItemClassification setImage:imageClassification];
    
    [self loadCompetitionDetails:idCompetitionServer];
    
}

#pragma mark - private methods
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(void) loadCompetitionDetails:(NSString *) idCompetition {
    //todo: should clean database.
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
                    [Utils deleteAllEntities:MATCH_ENTITY withContext:managedObjectContext];
                    [Utils deleteAllEntities:COURT_ENTITY withContext:managedObjectContext];
                    for (NSDictionary *matchDictionary in arrayMatches) {
                        [self insertMatch: matchDictionary];
                    }
                    NSArray *arrayClassification = [jsonResults objectForKey:@"classification"];
                    [Utils deleteAllEntities:CLASSIFICATION_ENTITY withContext:managedObjectContext];
                    for (NSDictionary *classification in arrayClassification) {
                        [self insertClassification:(NSDictionary *) classification];
                    }
                    CalendarTableViewController *calendarTableViewController = self.viewControllers[0];
                    [calendarTableViewController reloadDataTable];
                    ClassificationTableViewController *classificationTableViewController = self.viewControllers[1];
                    [classificationTableViewController reloadDataTable];
                });
            } else {
                NSLog(@"status: %ld", httpResponse.statusCode);
            }
        }
    }];
    [task resume];
}

-(void) insertClassification:(NSDictionary *) dictionaryClassification {
    ClassificationEntity *classificationEntry =  [NSEntityDescription
                                 insertNewObjectForEntityForName:CLASSIFICATION_ENTITY
                                 inManagedObjectContext:managedObjectContext];
    classificationEntry.competition = self.competitionEntity;
    //classificationEntry.matchesDrawn = (long)[dictionaryClassification objectForKey:@"matchesDrawn"];
    //classificationEntry.matchesLost = (long)[dictionaryClassification objectForKey:@"matchesLost"];
    //classificationEntry.matchesPlayed = (long)[dictionaryClassification objectForKey:@"matchesPlayed"];
    //classificationEntry.matchesWon = (long)[dictionaryClassification objectForKey:@"matchesWon"];
    classificationEntry.points = (int)[[dictionaryClassification objectForKey:@"points"] integerValue];
    classificationEntry.position = (int)[[dictionaryClassification objectForKey:@"position"] integerValue];
    classificationEntry.team = [dictionaryClassification objectForKey:@"team"];
    NSError *error = nil;
    if(![managedObjectContext save:&error]){
        NSLog(@"Error on insert -->%@", error.localizedDescription);
    }
}

//todo move this method to database utils class
-(void) insertMatch:(NSDictionary *) dictionaryMatch {
    MatchEntity *matchEntity =  [NSEntityDescription
                                             insertNewObjectForEntityForName:MATCH_ENTITY
                                             inManagedObjectContext:managedObjectContext];
    SportCourtEntity *courtEntity =  [NSEntityDescription
                                 insertNewObjectForEntityForName:COURT_ENTITY
                                 inManagedObjectContext:managedObjectContext];
    
    NSDictionary* teamLocal = [dictionaryMatch objectForKey:@"teamLocalEntity"];
    NSDictionary* teamVisitor = [dictionaryMatch objectForKey:@"teamVisitorEntity"];
    NSDictionary* sportCenterCourt = [dictionaryMatch objectForKey:@"sportCenterCourt"];
    NSDictionary* sportCenter = [sportCenterCourt objectForKey:@"sportCenter"];
    
    courtEntity.courtName = [sportCenterCourt objectForKey:@"nameWithCenter"];
    courtEntity.centerName = [sportCenter objectForKey:@"name"];
    courtEntity.centerAddress = [sportCenter objectForKey:@"address"];
    
    matchEntity.lastUpdate = (int)[[dictionaryMatch objectForKey:@"lastUpdate"] integerValue];
    matchEntity.scoreLocal = (int)[[dictionaryMatch objectForKey:@"scoreLocal"] integerValue];
    matchEntity.scoreVisitor = (int)[[dictionaryMatch objectForKey:@"scoreVisitor"] integerValue];
    matchEntity.state = (int)[[dictionaryMatch objectForKey:@"state"] integerValue];
    matchEntity.teamLocal = [teamLocal objectForKey:@"name"];
    matchEntity.teamVisitor = [teamVisitor objectForKey:@"name"];
    matchEntity.week = (int)[[dictionaryMatch objectForKey:@"week"] integerValue];
    matchEntity.date = [[dictionaryMatch objectForKey:@"date"] doubleValue];
    matchEntity.idServer = [[dictionaryMatch objectForKey:@"id"] doubleValue];
    matchEntity.competition = self.competitionEntity;
    matchEntity.court = courtEntity;
    NSError *error = nil;
    if(![managedObjectContext save:&error]){
        NSLog(@"Error on insert -->%@", error.localizedDescription);
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
      self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
