//
//  MatchEntity+CoreDataProperties.m
//  LocalSports
//
//  Created by Antonio Díaz Arroyo on 2/12/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "MatchEntity+CoreDataProperties.h"

@implementation MatchEntity (CoreDataProperties)

+ (NSFetchRequest<MatchEntity *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MatchEntity"];
}

@dynamic date;
@dynamic idServer;
@dynamic lastUpdate;
@dynamic scoreLocal;
@dynamic scoreVisitor;
@dynamic state;
@dynamic teamLocal;
@dynamic teamVisitor;
@dynamic week;
@dynamic competition;
@dynamic court;

@end
