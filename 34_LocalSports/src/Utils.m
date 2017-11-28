#import "Utils.h"

@implementation Utils

+(NSString*) enumSportToString:(EnumSports)enumSport {
    switch (enumSport) {
        case FOOTBALL:
            return @"FUTBOL_11";
        case BASKETBALL:
            return @"BALONCESTO";
        case VOLLEYBALL:
            return @"VOLEIBOL";
        case HANDBALL:
            return @"BALONMANO";
        case HOCKEY:
            return @"UNIHOCKEY";
        default:
            break;
    }
}

+ (void)deleteAllEntities:(NSString *)nameEntity withContext:(NSManagedObjectContext*)context {
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
@end
