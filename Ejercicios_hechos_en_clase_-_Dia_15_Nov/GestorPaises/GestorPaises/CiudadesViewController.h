//
//  CiudadesViewController.h
//  GestorPaises
//
//  Created by formador on 13/11/17.
//  Copyright © 2017 Cice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Pais+CoreDataClass.h"

@interface CiudadesViewController : UITableViewController <UIPopoverPresentationControllerDelegate>
{
    NSMutableArray *resultados;
}

@property (nonatomic, retain) NSManagedObjectContext *contexto;
@property (nonatomic, retain) Pais *pais;

@end
