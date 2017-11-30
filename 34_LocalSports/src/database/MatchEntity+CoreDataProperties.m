//
//  MatchEntity+CoreDataProperties.m
//  LocalSports
//
//  Created by cice on 30/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "MatchEntity+CoreDataProperties.h"

@implementation MatchEntity (CoreDataProperties)

+ (NSFetchRequest<MatchEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MatchEntity"];
}

@dynamic lastUpdate;
@dynamic scoreLocal;
@dynamic scoreVisitor;
@dynamic state;
@dynamic teamLocal;
@dynamic teamVisitor;
@dynamic week;
@dynamic date;
@dynamic competition;
@dynamic court;

@end
