//
//  ClassificationEntity+CoreDataProperties.m
//  LocalSports
//
//  Created by cice on 30/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "ClassificationEntity+CoreDataProperties.h"

@implementation ClassificationEntity (CoreDataProperties)

+ (NSFetchRequest<ClassificationEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ClassificationEntity"];
}

@dynamic matchesDrawn;
@dynamic matchesLost;
@dynamic matchesPlayed;
@dynamic matchesWon;
@dynamic points;
@dynamic position;
@dynamic team;
@dynamic competition;

@end
