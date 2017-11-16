//
//  Ciudad+CoreDataProperties.m
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//
//

#import "Ciudad+CoreDataProperties.h"

@implementation Ciudad (CoreDataProperties)

+ (NSFetchRequest<Ciudad *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Ciudad"];
}

@dynamic nombre;
@dynamic descripcion;
@dynamic imagen;
@dynamic pais;
@dynamic monumentos;

@end
