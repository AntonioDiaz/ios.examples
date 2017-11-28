//
//  ClassificationEntity+CoreDataProperties.m
//  LocalSports
//
//  Created by Antonio Díaz Arroyo on 28/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "ClassificationEntity+CoreDataProperties.h"

@implementation ClassificationEntity (CoreDataProperties)

+ (NSFetchRequest<ClassificationEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ClassificationEntity"];
}

@dynamic position;
@dynamic team;
@dynamic points;
@dynamic matchesPlayed;
@dynamic matchesWon;
@dynamic matchesDrawn;
@dynamic matchesLost;
@dynamic competition;

@end
