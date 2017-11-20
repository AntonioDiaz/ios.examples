//
//  AddLocationViewController.h
//  SaveLocationAndPictures
//
//  Created by cice on 20/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface AddLocationViewController : ViewController

@property (weak, nonatomic) IBOutlet UITextField *textViewTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLocation;
- (IBAction)actionLibrary:(id)sender;
- (IBAction)actionCamera:(id)sender;
- (IBAction)actionSaveLocation:(id)sender;

@property(nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
