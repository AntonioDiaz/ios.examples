//
//  LocationEntity+CoreDataProperties.m
//  SaveLocationAndPictures
//
//  Created by cice on 20/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "LocationEntity+CoreDataProperties.h"

@implementation LocationEntity (CoreDataProperties)

+ (NSFetchRequest<LocationEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"LocationEntity"];
}

@dynamic image;
@dynamic title;
@dynamic latitude;
@dynamic longitude;

@end
