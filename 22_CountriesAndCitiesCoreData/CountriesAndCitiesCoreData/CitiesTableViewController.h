//
//  CitiesTableViewController.h
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitiesTableViewController : UITableViewController<UIPopoverPresentationControllerDelegate>
@property (strong, nonatomic) IBOutlet NSString *countrySelectedName;
@end
