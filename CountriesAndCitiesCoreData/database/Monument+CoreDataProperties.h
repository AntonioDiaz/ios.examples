//
//  Monument+CoreDataProperties.h
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "Monument+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Monument (CoreDataProperties)

+ (NSFetchRequest<Monument *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, retain) City *relationship_city;
@property (nullable, nonatomic, retain) MonumentLocation *relationship_monument_location;

@end

NS_ASSUME_NONNULL_END
