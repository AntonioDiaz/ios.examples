//
//  Favorites.m
//  favorites
//
//  Created by cice on 3/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "Favorites.h"

@implementation Favorites

- (id) init {
    self = [super init];
    favoritesArray = [[NSMutableArray alloc]init];
    return self;
}

- (void) addFavorite:(FavoriteEntity*) favorite {
    [favoritesArray addObject:favorite];
}

- (NSMutableArray*) getFavorites {
    return favoritesArray;
}

- (NSInteger) getFavoritesCount {
    return [favoritesArray count];
}

@end
