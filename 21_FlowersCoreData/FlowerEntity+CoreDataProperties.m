//
//  FlowerEntity+CoreDataProperties.m
//  FlowersCoreData
//
//  Created by cice on 10/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "FlowerEntity+CoreDataProperties.h"

@implementation FlowerEntity (CoreDataProperties)

+ (NSFetchRequest<FlowerEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"FlowerEntity"];
}

@dynamic name;
@dynamic url;
@dynamic image;

@end
