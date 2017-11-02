//
//  ViewController.h
//  FlowersTable
//
//  Created by cice on 31/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate>
{
    NSDictionary *flowersDataSource;
}

@property (weak, nonatomic) IBOutlet UITableView *tableFlowers;


@end

