//
//  ClassificationEntity+CoreDataProperties.h
//  LocalSports
//
//  Created by Antonio Díaz Arroyo on 28/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "ClassificationEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ClassificationEntity (CoreDataProperties)

+ (NSFetchRequest<ClassificationEntity *> *)fetchRequest;

@property (nonatomic) int16_t position;
@property (nullable, nonatomic, copy) NSString *team;
@property (nonatomic) int16_t points;
@property (nonatomic) int16_t matchesPlayed;
@property (nonatomic) int16_t matchesWon;
@property (nonatomic) int16_t matchesDrawn;
@property (nonatomic) int16_t matchesLost;
@property (nullable, nonatomic, retain) CompetitionEntity *competition;

@end

NS_ASSUME_NONNULL_END
