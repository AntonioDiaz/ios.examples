//
//  UbicacionMonumento+CoreDataProperties.h
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//
//

#import "UbicacionMonumento+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UbicacionMonumento (CoreDataProperties)

+ (NSFetchRequest<UbicacionMonumento *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *latitud;
@property (nullable, nonatomic, copy) NSString *longitud;
@property (nullable, nonatomic, copy) NSString *altura;
@property (nullable, nonatomic, retain) Monumento *monumento;

@end

NS_ASSUME_NONNULL_END
