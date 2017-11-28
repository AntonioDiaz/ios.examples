//
//  Utils.m
//  LocalSports
//
//  Created by cice on 28/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

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

@end
