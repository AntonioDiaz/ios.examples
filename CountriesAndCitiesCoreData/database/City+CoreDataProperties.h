//
//  City+CoreDataProperties.h
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "City+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface City (CoreDataProperties)

+ (NSFetchRequest<City *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *desc;
@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) Country *relationship_country;
@property (nullable, nonatomic, retain) NSSet<Monument *> *relationship_monument;

@end

@interface City (CoreDataGeneratedAccessors)

- (void)addRelationship_monumentObject:(Monument *)value;
- (void)removeRelationship_monumentObject:(Monument *)value;
- (void)addRelationship_monument:(NSSet<Monument *> *)values;
- (void)removeRelationship_monument:(NSSet<Monument *> *)values;

@end

NS_ASSUME_NONNULL_END
