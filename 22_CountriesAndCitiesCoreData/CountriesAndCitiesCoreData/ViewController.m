//
//  ViewController.m
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Country+CoreDataProperties.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions
- (IBAction)actionSave:(id)sender {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    //check if fields are filled
    Boolean nameEmpty = [self.textFieldName.text length]==0;
    Boolean imageEmpty = [self.textFieldImage.text length]==0;
    if (nameEmpty || imageEmpty) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"error" message:@"Fill name and image, please" delegate:self cancelButtonTitle:@"Accept" otherButtonTitles: nil];
        [alertView show];
    } else {
        //check if country exist.
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSEntityDescription *description = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:context];
        [request setEntity:description];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", self.textFieldName.text];
        [request setPredicate:predicate];
        NSError *error;
        NSArray *queryResults = [context executeFetchRequest:request error:&error];
        NSString *saveMsg;
        if (queryResults!=nil) {
            if ([queryResults count]==0) {
                Country *countryNew = [NSEntityDescription insertNewObjectForEntityForName:@"Country" inManagedObjectContext:context];
                countryNew.image = self.textFieldImage.text;
                countryNew.name = self.textFieldName.text;
                saveMsg = @"new country";
            } else {
                Country *countryUpdate = [queryResults objectAtIndex:0];
                countryUpdate.image = self.textFieldImage.text;
                saveMsg = @"update country";
            }
            if (![context save:&error]) {
                NSLog(@"ERROR on save");
            } else {
                [self saveImage:self.textFieldImage.text finalImage:self.textFieldName.text];
            }
        }
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"save ok" message:saveMsg delegate:self cancelButtonTitle:@"Accept" otherButtonTitles: nil];
        [alertView show];
    }
}

#pragma mark - private methods
-(void) saveImage:(NSString *) url finalImage:(NSString*) imageName {
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    
    //recuperamos el archivo original en formato NSData.
    NSData *imageDetails = [NSData dataWithContentsOfURL:[NSURL URLWithString: url]];
    
    //guardamos en la ubicaión final.
    NSString *finalFile = [NSString stringWithFormat:@"%@/%@.jpg", documentsDirectoryPath, imageName];
    NSError *error = nil;
    [imageDetails  writeToFile:finalFile options:NSDataWritingAtomic error:&error];
    NSLog(@"%@", finalFile);
    //NSLog(@"image %@", &error );
}

@end
