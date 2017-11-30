//
//  CompetitionEntity+CoreDataProperties.h
//  LocalSports
//
//  Created by cice on 30/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "CompetitionEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface CompetitionEntity (CoreDataProperties)

+ (NSFetchRequest<CompetitionEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *category;
@property (nonatomic) int32_t categoryOrder;
@property (nonatomic) double idCompetitionServer;
@property (nullable, nonatomic, copy) NSString *lastUpdateApp;
@property (nullable, nonatomic, copy) NSString *lastUpdateServer;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *sport;
@property (nullable, nonatomic, retain) NSSet<ClassificationEntity *> *classification;
@property (nullable, nonatomic, retain) NSSet<MatchEntity *> *matches;

@end

@interface CompetitionEntity (CoreDataGeneratedAccessors)

- (void)addClassificationObject:(ClassificationEntity *)value;
- (void)removeClassificationObject:(ClassificationEntity *)value;
- (void)addClassification:(NSSet<ClassificationEntity *> *)values;
- (void)removeClassification:(NSSet<ClassificationEntity *> *)values;

- (void)addMatchesObject:(MatchEntity *)value;
- (void)removeMatchesObject:(MatchEntity *)value;
- (void)addMatches:(NSSet<MatchEntity *> *)values;
- (void)removeMatches:(NSSet<MatchEntity *> *)values;

@end

NS_ASSUME_NONNULL_END
