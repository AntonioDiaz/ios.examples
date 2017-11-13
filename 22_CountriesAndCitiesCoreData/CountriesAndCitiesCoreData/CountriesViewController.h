//
//  CountriesViewController.h
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface CountriesViewController : UITableViewController <UIAlertViewDelegate> {
    NSMutableArray *results;
}

@property(nonatomic, retain) NSManagedObjectContext *context;

@end
