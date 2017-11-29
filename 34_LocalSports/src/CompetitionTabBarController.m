#import "CompetitionTabBarController.h"
#import "MatchEntity+CoreDataProperties.h"
#import "AppDelegate.h"
#import "Utils.h"

@implementation CompetitionTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ - %@", self.competitionEntity.category, self.competitionEntity.name];
    
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    managedObjectContext = app.persistentContainer.viewContext;
    
    //load competitions details on DB.
    NSString *idCompetitionServer = [NSString stringWithFormat: @"%f", self.competitionEntity.idCompetitionServer];

    [self loadCompetitionDetails:idCompetitionServer];
    
}

#pragma mark - private methods
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
                [Utils deleteAllEntities:MATCH_ENTITY withContext:managedObjectContext];
                for (NSDictionary *matchDictionary in arrayMatches) {
                    [self insertMatch: matchDictionary];
                }
                NSArray *arrayClassification = [jsonResults objectForKey:@"classification"];
                [Utils deleteAllEntities:CLASSIFICATION_ENTITY withContext:managedObjectContext];
                for (NSDictionary *matchClassification in arrayClassification) {
                    [self insertClassification:(NSDictionary *) matchClassification];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    //first remove all competitions.
                    
                });
            } else {
                NSLog(@"status: %ld", httpResponse.statusCode);
            }
        }
    }];
    [task resume];
}

-(void) insertClassification:(NSDictionary *) dictionaryClassification {
}

//todo move this method to database utils class
-(void) insertMatch:(NSDictionary *) dictionaryMatch {
    MatchEntity *matchEntity =  [NSEntityDescription
                                             insertNewObjectForEntityForName:MATCH_ENTITY
                                             inManagedObjectContext:managedObjectContext];
    NSDictionary* teamLocal = [dictionaryMatch objectForKey:@"teamLocalEntity"];
    NSDictionary* teamVisitor = [dictionaryMatch objectForKey:@"teamVisitorEntity"];
    matchEntity.lastUpdate = [[dictionaryMatch objectForKey:@"date"] integerValue];
    matchEntity.scoreLocal = [[dictionaryMatch objectForKey:@"scoreLocal"] integerValue];
    matchEntity.scoreVisitor = [[dictionaryMatch objectForKey:@"scoreVisitor"] integerValue];
    matchEntity.teamLocal = [teamLocal objectForKey:@"name"];
    matchEntity.teamVisitor = [teamVisitor objectForKey:@"name"];
    matchEntity.state = [[dictionaryMatch objectForKey:@"state"] integerValue];
    matchEntity.competition = self.competitionEntity;
    NSError *error = nil;
    if(![managedObjectContext save:&error]){
        NSLog(@"Error on insert -->%@", error.localizedDescription);
    }
    NSLog(@"Insert done %@ - %@", competitionEntity.name, competitionEntity.sport);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
