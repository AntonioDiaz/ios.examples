//
//  Monumento+CoreDataProperties.m
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//
//

#import "Monumento+CoreDataProperties.h"

@implementation Monumento (CoreDataProperties)

+ (NSFetchRequest<Monumento *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Monumento"];
}

@dynamic nombre;
@dynamic imagen;
@dynamic url;
@dynamic ciudad;
@dynamic ubicacion;

@end
