//
//  FavoriteEntity.m
//  favorites
//
//  Created by cice on 3/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "FavoriteEntity.h"

@implementation FavoriteEntity

@synthesize name;
@synthesize urlString;

- (id) initFavorite: (NSString *) name andUrl: (NSString *) urlString {
    self = [super init];
    self.name = name;
    self.urlString = urlString;
    return self;
}

@end
