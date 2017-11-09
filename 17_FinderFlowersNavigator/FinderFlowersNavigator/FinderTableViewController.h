//
//  FinderTableViewController.h
//  FinderFlowersNavigator
//
//  Created by cice on 8/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FinderTableViewController : UITableViewController <UISearchResultsUpdating, UISearchBarDelegate, UINavigationControllerDelegate>{
    NSMutableArray *flowersShown;
    NSMutableArray *allFlowersArray;
    UISearchController *searchController;
}

@end
