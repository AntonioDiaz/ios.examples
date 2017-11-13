//
//  MonumentLocation+CoreDataProperties.h
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "MonumentLocation+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MonumentLocation (CoreDataProperties)

+ (NSFetchRequest<MonumentLocation *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *height;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;
@property (nullable, nonatomic, retain) Monument *relationship_monument_location;

@end

NS_ASSUME_NONNULL_END
