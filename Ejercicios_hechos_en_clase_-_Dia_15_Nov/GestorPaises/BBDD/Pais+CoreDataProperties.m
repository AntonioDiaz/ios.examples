//
//  Pais+CoreDataProperties.m
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//
//

#import "Pais+CoreDataProperties.h"

@implementation Pais (CoreDataProperties)

+ (NSFetchRequest<Pais *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Pais"];
}

@dynamic nombre;
@dynamic imagen;
@dynamic ciudades;

@end
