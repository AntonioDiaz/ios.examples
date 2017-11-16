//
//  UbicacionMonumento+CoreDataProperties.m
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//
//

#import "UbicacionMonumento+CoreDataProperties.h"

@implementation UbicacionMonumento (CoreDataProperties)

+ (NSFetchRequest<UbicacionMonumento *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UbicacionMonumento"];
}

@dynamic latitud;
@dynamic longitud;
@dynamic altura;
@dynamic monumento;

@end
