//
//  LocationEntity+CoreDataProperties.h
//  SaveLocationAndPictures
//
//  Created by cice on 20/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "LocationEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface LocationEntity (CoreDataProperties)

+ (NSFetchRequest<LocationEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *image;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *latitude;
@property (nullable, nonatomic, copy) NSString *longitude;

@end

NS_ASSUME_NONNULL_END
