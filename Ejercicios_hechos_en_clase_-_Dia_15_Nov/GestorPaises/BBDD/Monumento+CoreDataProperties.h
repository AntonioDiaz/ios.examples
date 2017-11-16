//
//  Monumento+CoreDataProperties.h
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//
//

#import "Monumento+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Monumento (CoreDataProperties)

+ (NSFetchRequest<Monumento *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *nombre;
@property (nullable, nonatomic, copy) NSString *imagen;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) Ciudad *ciudad;
@property (nullable, nonatomic, retain) UbicacionMonumento *ubicacion;

@end

NS_ASSUME_NONNULL_END
