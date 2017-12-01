//
//  MatchEntity+CoreDataProperties.m
//  LocalSports
//
//  Created by cice on 1/12/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "MatchEntity+CoreDataProperties.h"

@implementation MatchEntity (CoreDataProperties)

+ (NSFetchRequest<MatchEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MatchEntity"];
}

@dynamic date;
@dynamic lastUpdate;
@dynamic scoreLocal;
@dynamic scoreVisitor;
@dynamic state;
@dynamic teamLocal;
@dynamic teamVisitor;
@dynamic week;
@dynamic idServer;
@dynamic competition;
@dynamic court;

@end
