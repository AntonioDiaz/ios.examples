//
//  FavoriteEntity+CoreDataProperties.h
//  LocalSports
//
//  Created by Antonio Díaz Arroyo on 28/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "FavoriteEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoriteEntity (CoreDataProperties)

+ (NSFetchRequest<FavoriteEntity *> *)fetchRequest;

@property (nonatomic) int32_t lastUpdate;
@property (nullable, nonatomic, copy) NSString *team;
@property (nullable, nonatomic, retain) CompetitionEntity *competition;

@end

NS_ASSUME_NONNULL_END
