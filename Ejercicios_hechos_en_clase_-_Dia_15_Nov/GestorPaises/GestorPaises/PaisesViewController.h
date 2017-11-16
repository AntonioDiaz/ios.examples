//
//  PaisesViewController.h
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaisesViewController : UITableViewController
{
    NSMutableArray *resultados;
}

@property (nonatomic, retain) NSManagedObjectContext *contexto;

@end
