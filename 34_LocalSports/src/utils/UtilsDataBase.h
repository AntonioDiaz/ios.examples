#import <Foundation/Foundation.h>
#import "CompetitionEntity+CoreDataProperties.h"
#import "ClassificationEntity+CoreDataProperties.h"
#import "MatchEntity+CoreDataProperties.h"
#import "SportCourtEntity+CoreDataProperties.h"

@interface UtilsDataBase : NSObject

+(NSArray *) queryMatches:(CompetitionEntity *) competitionEntity;
+(NSArray *) queryClassification:(CompetitionEntity *) competitionEntity;
+(NSArray *) queryCompetitionsBySport:(NSString *) sportStr;
+(void) deleteClassification:(CompetitionEntity *)competitionEntity;
+(void) deleteMatches:(CompetitionEntity *)competitionEntity;
+(void) deleteAllEntities:(NSString *)nameEntity;
+(void) insertCompetition:(NSDictionary *) dictionaryCompetition;
+(void) insertClassification:(NSDictionary *) dictionaryMatch withEntity:(CompetitionEntity *) competition;
+(void) insertMatch:(NSDictionary *) dictionaryMatch withEntity:(CompetitionEntity *) competition;
@end
