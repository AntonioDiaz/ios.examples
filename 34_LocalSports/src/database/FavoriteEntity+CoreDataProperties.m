//
//  FavoriteEntity+CoreDataProperties.m
//  LocalSports
//
//  Created by cice on 30/11/17.
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
