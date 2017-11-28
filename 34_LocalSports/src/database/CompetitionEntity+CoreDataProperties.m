//
//  CompetitionEntity+CoreDataProperties.m
//  LocalSports
//
//  Created by Antonio Díaz Arroyo on 28/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "CompetitionEntity+CoreDataProperties.h"

@implementation CompetitionEntity (CoreDataProperties)

+ (NSFetchRequest<CompetitionEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"CompetitionEntity"];
}

@dynamic name;
@dynamic sport;
@dynamic category;
@dynamic categoryOrder;
@dynamic idCompetitionServer;
@dynamic lastUpdateServer;
@dynamic lastUpdateApp;
@dynamic matches;
@dynamic classification;

@end
