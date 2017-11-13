//
//  Country+CoreDataProperties.h
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "Country+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Country (CoreDataProperties)

+ (NSFetchRequest<Country *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<City *> *relationship_country_city;

@end

@interface Country (CoreDataGeneratedAccessors)

- (void)addRelationship_country_cityObject:(City *)value;
- (void)removeRelationship_country_cityObject:(City *)value;
- (void)addRelationship_country_city:(NSSet<City *> *)values;
- (void)removeRelationship_country_city:(NSSet<City *> *)values;

@end

NS_ASSUME_NONNULL_END
