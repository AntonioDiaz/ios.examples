//
//  MonumentLocation+CoreDataProperties.m
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "MonumentLocation+CoreDataProperties.h"

@implementation MonumentLocation (CoreDataProperties)

+ (NSFetchRequest<MonumentLocation *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MonumentLocation"];
}

@dynamic height;
@dynamic latitude;
@dynamic longitude;
@dynamic relationship_monument_location;

@end
