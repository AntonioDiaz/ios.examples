//
//  CompetitionEntity+CoreDataProperties.m
//  LocalSports
//
//  Created by Antonio Díaz Arroyo on 2/12/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "CompetitionEntity+CoreDataProperties.h"

@implementation CompetitionEntity (CoreDataProperties)

+ (NSFetchRequest<CompetitionEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CompetitionEntity"];
}

@dynamic category;
@dynamic categoryOrder;
@dynamic idCompetitionServer;
@dynamic lastUpdateApp;
@dynamic lastUpdateServer;
@dynamic name;
@dynamic sport;
@dynamic classification;
@dynamic matches;

@end
