//
//  ViewController.h
//  FlowersCoreData
//
//  Created by cice on 10/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, retain) NSManagedObjectContext *context;
@property(nonatomic, retain) NSMutableArray *arrayFlowers;



@end

