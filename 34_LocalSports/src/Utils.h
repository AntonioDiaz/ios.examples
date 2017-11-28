#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface Utils : NSObject

#define URL_TOWNS @"https://localsports-web.appspot.com/server/towns"
#define URL_COMPETITIONS @"https://localsports-web.appspot.com/server/search_competitions/?idTown=%@"
#define APP_NAME @"LocalSports"
#define PREF_TOWN_NAME @"PREF_TOWN_NAME"
#define PREF_TOWN_ID @"PREF_TOWN_ID"
#define COMPETITION_ENTITY @"CompetitionEntity"
#define UIColorFromRGB(rgbValue) \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
    green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
    blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
    alpha:1.0]


typedef NS_ENUM(NSInteger, EnumSports) {
    FOOTBALL = 1,
    BASKETBALL,
    VOLLEYBALL,
    HANDBALL,
    HOCKEY
};

+(NSString*) enumSportToString:(EnumSports)enumSport;
+ (void)deleteAllEntities:(NSString *)nameEntity withContext:(NSManagedObjectContext*)context;

@end
