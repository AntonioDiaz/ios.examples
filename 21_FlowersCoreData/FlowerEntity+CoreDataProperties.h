//
//  FlowerEntity+CoreDataProperties.h
//  FlowersCoreData
//
//  Created by cice on 10/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "FlowerEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FlowerEntity (CoreDataProperties)

+ (NSFetchRequest<FlowerEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *url;
@property (nullable, nonatomic, copy) NSString *image;

@end

NS_ASSUME_NONNULL_END
