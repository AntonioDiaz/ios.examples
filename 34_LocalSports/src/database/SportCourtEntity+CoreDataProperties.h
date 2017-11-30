//
//  SportCourtEntity+CoreDataProperties.h
//  LocalSports
//
//  Created by cice on 30/11/17.
//  Copyright © 2017 cice. All rights reserved.
//
//

#import "SportCourtEntity+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface SportCourtEntity (CoreDataProperties)

+ (NSFetchRequest<SportCourtEntity *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *centerAddress;
@property (nullable, nonatomic, copy) NSString *centerName;
@property (nullable, nonatomic, copy) NSString *courtName;
@property (nonatomic) int16_t idServer;
@property (nullable, nonatomic, retain) NSSet<MatchEntity *> *matches;

@end

@interface SportCourtEntity (CoreDataGeneratedAccessors)

- (void)addMatchesObject:(MatchEntity *)value;
- (void)removeMatchesObject:(MatchEntity *)value;
- (void)addMatches:(NSSet<MatchEntity *> *)values;
- (void)removeMatches:(NSSet<MatchEntity *> *)values;

@end

NS_ASSUME_NONNULL_END