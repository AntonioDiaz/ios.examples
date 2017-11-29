//
//  MatchEntity+CoreDataProperties.h
//  LocalSports
//
//  Created by Antonio Díaz Arroyo on 29/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "MatchEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MatchEntity (CoreDataProperties)

+ (NSFetchRequest<MatchEntity *> *)fetchRequest;

@property (nonatomic) int32_t lastUpdate;
@property (nonatomic) int32_t scoreLocal;
@property (nonatomic) int32_t scoreVisitor;
@property (nonatomic) int32_t state;
@property (nullable, nonatomic, copy) NSString *teamLocal;
@property (nullable, nonatomic, copy) NSString *teamVisitor;
@property (nonatomic) int32_t week;
@property (nullable, nonatomic, retain) CompetitionEntity *competition;
@property (nullable, nonatomic, retain) SportCourtEntity *court;

@end

NS_ASSUME_NONNULL_END
