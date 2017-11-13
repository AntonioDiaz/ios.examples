//
//  ViewController.m
//  FlowersCoreData
//
//  Created by cice on 10/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "FlowerEntity+CoreDataClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //get context from persistence coordinator.
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    self.context = app.persistentContainer.viewContext;
    //create and init flower.
    FlowerEntity *flowerEntity = [NSEntityDescription insertNewObjectForEntityForName:@"FlowerEntity" inManagedObjectContext:self.context];
    flowerEntity.name = @"Rose";
    flowerEntity.url = @"http://www.rose.com";
    flowerEntity.image = @"rose.jpg";
    
    //update DB with the actual context.
    NSError *error = nil;
    if(![self.context save:&error]){ }
    //query all flowers.
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FlowerEntity" inManagedObjectContext:self.context];
    [request setEntity:entity];
    
    
    self.arrayFlowers = [self.context executeFetchRequest:request error:&error];
    if (self.arrayFlowers != nil) {
        for (FlowerEntity *flowerLoop in self.arrayFlowers) {
            NSLog(@"Flower name %@", flowerLoop.name );
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
