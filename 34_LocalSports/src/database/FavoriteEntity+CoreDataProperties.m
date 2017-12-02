//
//  FavoriteEntity+CoreDataProperties.m
//  LocalSports
//
//  Created by Antonio Díaz Arroyo on 2/12/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "FavoriteEntity+CoreDataProperties.h"

@implementation FavoriteEntity (CoreDataProperties)

+ (NSFetchRequest<FavoriteEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FavoriteEntity"];
}

@dynamic lastUpdate;
@dynamic team;
@dynamic competition;

@end
