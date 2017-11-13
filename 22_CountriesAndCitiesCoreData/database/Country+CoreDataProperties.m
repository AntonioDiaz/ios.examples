//
//  Country+CoreDataProperties.m
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "Country+CoreDataProperties.h"

@implementation Country (CoreDataProperties)

+ (NSFetchRequest<Country *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Country"];
}

@dynamic image;
@dynamic name;
@dynamic relationship_country_city;

@end
