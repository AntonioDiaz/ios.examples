//
//  Monument+CoreDataProperties.m
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "Monument+CoreDataProperties.h"

@implementation Monument (CoreDataProperties)

+ (NSFetchRequest<Monument *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Monument"];
}

@dynamic image;
@dynamic name;
@dynamic url;
@dynamic relationship_city;
@dynamic relationship_monument_location;

@end
