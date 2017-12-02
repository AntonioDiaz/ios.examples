#import "UtilsDataBase.h"
#import "AppDelegate.h"
#import "Utils.h"

@implementation UtilsDataBase

+(NSArray *) queryMatches:(CompetitionEntity *) competitionEntity {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:MATCH_ENTITY inManagedObjectContext:context];
    [request setEntity:description];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"competition == %@", competitionEntity];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchesArray = [context executeFetchRequest:request error:&error];
    if(error){
        NSLog(@"queryMatches error -->%@", error.localizedDescription);
    }
    return matchesArray;
}

+(NSArray *) queryClassification:(CompetitionEntity *)competitionEntity {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:CLASSIFICATION_ENTITY inManagedObjectContext:context];
    [request setEntity:description];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"competition == %@", competitionEntity];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *matchesClassification = [context executeFetchRequest:request error:&error];
    if(error){
        NSLog(@"queryClassification error -->%@", error.localizedDescription);
    }
    return matchesClassification;

}

+(NSArray *) queryCompetitionsBySport:(NSString *) sportStr {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:COMPETITION_ENTITY inManagedObjectContext:context];
    [request setEntity:description];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sport == %@", sportStr];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *arrayCompetitions = [context executeFetchRequest:request error:&error];
    if(error){
        NSLog(@"queryCompetitionsBySport error -->%@", error.localizedDescription);
    }
    return arrayCompetitions;
}

+(SportCourtEntity *) querySportCourtById:(long) idServer {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:COURT_ENTITY inManagedObjectContext:context];
    [request setEntity:description];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"idServer == %ld", idServer];
    [request setPredicate:predicate];
    NSError *error;
    NSArray *courts = [context executeFetchRequest:request error:&error];
    if(error){
        NSLog(@"querySportCourtById error -->%@", error.localizedDescription);
    }
    return courts.count==0 ? nil: [courts objectAtIndex:0];
}

+(void) deleteClassification:(CompetitionEntity *)competitionEntity {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    NSError *error;
    NSArray *fetchedObjects = [UtilsDataBase queryClassification:competitionEntity];
    for (NSManagedObject *object in fetchedObjects) {
        [context deleteObject:object];
    }
    error = nil;
    [context save:&error];
    if(error){
        NSLog(@"deleteClassification error -->%@", error.localizedDescription);
    }
}

+(void) deleteMatches:(CompetitionEntity *)competitionEntity {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    NSError *error;
    NSArray *fetchedObjects = [UtilsDataBase queryMatches:competitionEntity];
    for (NSManagedObject *object in fetchedObjects) {
        [context deleteObject:object];
    }
    error = nil;
    [context save:&error];
    if(error){
        NSLog(@"deleteMatches error -->%@", error.localizedDescription);
    }
}

+(void) deleteAllEntities:(NSString *)nameEntity {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:nameEntity];
    [fetchRequest setIncludesPropertyValues:NO];
    NSError *error;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    for (NSManagedObject *object in fetchedObjects) {
        [context deleteObject:object];
    }
    error = nil;
    [context save:&error];
    if(error){
        NSLog(@"deleteAllEntities error -->%@", error.localizedDescription);
    }
}

+(void) insertCompetition:(NSDictionary *) dictionaryCompetition {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    CompetitionEntity *competitionEntity =  [NSEntityDescription
                                             insertNewObjectForEntityForName:COMPETITION_ENTITY
                                             inManagedObjectContext:context];
    NSDictionary *dictionaryCategory = [dictionaryCompetition objectForKey:@"categoryEntity"];
    NSDictionary *dictionarySport = [dictionaryCompetition objectForKey:@"sportEntity"];
    competitionEntity.category = [dictionaryCategory objectForKey:@"name"];
    competitionEntity.categoryOrder = (int)[[dictionaryCategory objectForKey:@"order"] integerValue];
    competitionEntity.idCompetitionServer = [[dictionaryCompetition objectForKey:@"id"] doubleValue];
    //competitionEntity.lastUpdateApp = [dictionaryCompetition objectForKey:@"lastPublished"];
    //competitionEntity.lastUpdateServer = [dictionaryCompetition objectForKey:@"lastPublished"];
    competitionEntity.name = [dictionaryCompetition objectForKey:@"name"];
    competitionEntity.sport = [dictionarySport objectForKey:@"tag"];
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Error on insert -->%@", error.localizedDescription);
    }
}

/** insert classification entry in DB. */
+(void) insertClassification:(NSDictionary *) dictionaryClassification withEntity:(CompetitionEntity *) competition {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    ClassificationEntity *classificationEntry =  [NSEntityDescription
                                                  insertNewObjectForEntityForName:CLASSIFICATION_ENTITY
                                                  inManagedObjectContext:context];
    classificationEntry.competition = competition;
    //classificationEntry.matchesDrawn = (long)[dictionaryClassification objectForKey:@"matchesDrawn"];
    //classificationEntry.matchesLost = (long)[dictionaryClassification objectForKey:@"matchesLost"];
    //classificationEntry.matchesPlayed = (long)[dictionaryClassification objectForKey:@"matchesPlayed"];
    //classificationEntry.matchesWon = (long)[dictionaryClassification objectForKey:@"matchesWon"];
    classificationEntry.points = (int)[[dictionaryClassification objectForKey:@"points"] integerValue];
    classificationEntry.position = (int)[[dictionaryClassification objectForKey:@"position"] integerValue];
    classificationEntry.team = [dictionaryClassification objectForKey:@"team"];
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Error on insert -->%@", error.localizedDescription);
    }
}

/** insert match entry in DB. */
+(void) insertMatch:(NSDictionary *) dictionaryMatch withEntity:(CompetitionEntity *) competition {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    MatchEntity *matchEntity =  [NSEntityDescription
                                 insertNewObjectForEntityForName:MATCH_ENTITY
                                 inManagedObjectContext:context];
    NSDictionary* dictionaryTeamLocal = [dictionaryMatch objectForKey:@"teamLocalEntity"];
    NSDictionary* dictionaryTeamVisitor = [dictionaryMatch objectForKey:@"teamVisitorEntity"];
    NSDictionary* dictionarySportCenterCourt = [dictionaryMatch objectForKey:@"sportCenterCourt"];
    SportCourtEntity *courtEntity = [self insertOrUpdateCourtEntity:dictionarySportCenterCourt];
    matchEntity.lastUpdate = (int)[[dictionaryMatch objectForKey:@"lastUpdate"] integerValue];
    matchEntity.scoreLocal = (int)[[dictionaryMatch objectForKey:@"scoreLocal"] integerValue];
    matchEntity.scoreVisitor = (int)[[dictionaryMatch objectForKey:@"scoreVisitor"] integerValue];
    matchEntity.state = (int)[[dictionaryMatch objectForKey:@"state"] integerValue];
    matchEntity.teamLocal = [dictionaryTeamLocal objectForKey:@"name"];
    matchEntity.teamVisitor = [dictionaryTeamVisitor objectForKey:@"name"];
    matchEntity.week = (int)[[dictionaryMatch objectForKey:@"week"] integerValue];
    matchEntity.date = [[dictionaryMatch objectForKey:@"date"] doubleValue];
    matchEntity.idServer = [[dictionaryMatch objectForKey:@"id"] doubleValue];
    matchEntity.competition = competition;
    matchEntity.court = courtEntity;
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Error on insert -->%@", error.localizedDescription);
    }
}

+(SportCourtEntity *) insertOrUpdateCourtEntity:(NSDictionary *) dictionary {
    NSManagedObjectContext *context = [self getContext];
    //check if exist this sportCenter.
    long idServer = [[dictionary objectForKey:@"id"] longValue];
    SportCourtEntity *sportCenterEntity = [self querySportCourtById:idServer];
    if (!sportCenterEntity) {
        sportCenterEntity =  [NSEntityDescription
                         insertNewObjectForEntityForName:COURT_ENTITY
                         inManagedObjectContext:context];
    }
    NSDictionary* sportCenterDictionary = [dictionary objectForKey:@"sportCenter"];
    sportCenterEntity.courtName = [dictionary objectForKey:@"nameWithCenter"];
    sportCenterEntity.centerName = [sportCenterDictionary objectForKey:@"name"];
    sportCenterEntity.centerAddress = [sportCenterDictionary objectForKey:@"address"];
    sportCenterEntity.idServer = idServer;
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Error on insertOrUpdateCourtEntity -->%@", error.localizedDescription);
    }
    return sportCenterEntity;
}

+(NSManagedObjectContext *) getContext {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    return app.persistentContainer.viewContext;
}

@end
