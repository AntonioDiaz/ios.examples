//
//  Utils.h
//  LocalSports
//
//  Created by cice on 28/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

#define URL_TOWNS @"https://localsports-web.appspot.com/server/towns"
#define URL_COMPETITIONS @"https://localsports-web.appspot.com/server/search_competitions/?idTown=%@"
#define APP_NAME @"LocalSports"
#define PREF_TOWN_NAME @"PREF_TOWN_NAME"
#define PREF_TOWN_ID @"PREF_TOWN_ID"


typedef NS_ENUM(NSInteger, EnumSports) {
    FOOTBALL = 1,
    BASKETBALL,
    VOLLEYBALL,
    HANDBALL,
    HOCKEY
};

+(NSString*) enumSportToString:(EnumSports)enumSport;


@end
