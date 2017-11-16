//
//  Ciudad+CoreDataProperties.h
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//
//

#import "Ciudad+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Ciudad (CoreDataProperties)

+ (NSFetchRequest<Ciudad *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *nombre;
@property (nullable, nonatomic, copy) NSString *descripcion;
@property (nullable, nonatomic, copy) NSString *imagen;
@property (nullable, nonatomic, retain) Pais *pais;
@property (nullable, nonatomic, retain) NSSet<Monumento *> *monumentos;

@end

@interface Ciudad (CoreDataGeneratedAccessors)

- (void)addMonumentosObject:(Monumento *)value;
- (void)removeMonumentosObject:(Monumento *)value;
- (void)addMonumentos:(NSSet<Monumento *> *)values;
- (void)removeMonumentos:(NSSet<Monumento *> *)values;

@end

NS_ASSUME_NONNULL_END
