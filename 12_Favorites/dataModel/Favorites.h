//
//  Favorites.h
//  favorites
//
//  Created by cice on 3/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FavoriteEntity.h"

@interface Favorites : NSObject {
    NSMutableArray *favoritesArray;
}
- (void) addFavorite:(FavoriteEntity*) favorite;
- (NSInteger) getFavoritesCount;
- (NSMutableArray*) getFavorites;
//- (id) initialize;
@end
