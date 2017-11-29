//
//  SportCourtEntity+CoreDataProperties.m
//  LocalSports
//
//  Created by Antonio Díaz Arroyo on 29/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "SportCourtEntity+CoreDataProperties.h"

@implementation SportCourtEntity (CoreDataProperties)

+ (NSFetchRequest<SportCourtEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"SportCourtEntity"];
}

@dynamic centerAddress;
@dynamic centerName;
@dynamic courtName;
@dynamic idServer;
@dynamic matches;

@end
