//
//  Pais+CoreDataProperties.h
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//
//

#import "Pais+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Pais (CoreDataProperties)

+ (NSFetchRequest<Pais *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *nombre;
@property (nullable, nonatomic, copy) NSString *imagen;
@property (nullable, nonatomic, retain) NSSet<Ciudad *> *ciudades;

@end

@interface Pais (CoreDataGeneratedAccessors)

- (void)addCiudadesObject:(Ciudad *)value;
- (void)removeCiudadesObject:(Ciudad *)value;
- (void)addCiudades:(NSSet<Ciudad *> *)values;
- (void)removeCiudades:(NSSet<Ciudad *> *)values;

@end

NS_ASSUME_NONNULL_END
