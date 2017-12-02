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
    return [context executeFetchRequest:request error:&error];
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
    return [context executeFetchRequest:request error:&error];
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
    SportCourtEntity *courtEntity =  [NSEntityDescription
                                      insertNewObjectForEntityForName:COURT_ENTITY
                                      inManagedObjectContext:context];
    
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
    matchEntity.competition = competition;
    matchEntity.court = courtEntity;
    NSError *error = nil;
    if(![context save:&error]){
        NSLog(@"Error on insert -->%@", error.localizedDescription);
    }
}


@end
