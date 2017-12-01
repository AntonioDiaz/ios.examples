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

+(void)showComingSoon {
    [self showAlert:@"comming soon"];
}

+(void)showAlert:(NSString *) alertDesc {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:APP_NAME message:alertDesc delegate:self cancelButtonTitle:@"Accept" otherButtonTitles: nil];
    [alertView show];
}

+(NSString*) formatDate:(NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd/MM/yyyy HH:mm"];
    return [dateFormatter stringFromDate:date];
}

+(NSDate*) formatDateDoubleToDate:(double) dateDouble {
    double timestampval = dateDouble / 1000;
    NSTimeInterval timestamp = (NSTimeInterval)timestampval;
    return [NSDate dateWithTimeIntervalSince1970:timestamp];
}

+(NSString*) formatDateDoubleToStr:(double) dateDouble {
    NSDate* date = [self formatDateDoubleToDate:dateDouble];
    return [self formatDate:date];
}

+(NSString *) dictionaryToString:(NSDictionary *) dictionary {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *jsonString = nil;
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
@end
