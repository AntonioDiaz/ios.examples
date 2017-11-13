//
//  CountriesViewController.m
//  CountriesAndCitiesCoreData
//
//  Created by cice on 13/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "CountriesViewController.h"
#import "AppDelegate.h"
#import "Country+CoreDataClass.h"
#import "CitiesTableViewController.h"

@interface CountriesViewController ()

@end

@implementation CountriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(void)viewWillAppear:(BOOL)animated {
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.context = app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Country" inManagedObjectContext:self.context];
    [request setEntity:description];
    NSSortDescriptor *orderByName = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    [request setSortDescriptors: [[NSArray alloc] initWithObjects:orderByName, nil]];
    NSError *error = nil;
    NSArray *resultsArray = [self.context executeFetchRequest:request error:&error];
    results = [resultsArray mutableCopy];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Country *country = [results objectAtIndex:indexPath.row];
    NSLog(@"%@", country.name);
    CitiesTableViewController *citiesTableViewController = segue.destinationViewController;
    citiesTableViewController.countrySelectedName = country.name;
}


#pragma mark - UITableViewDataSource
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   return [results count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    Country *country = [results objectAtIndex:indexPath.row];
    cell.textLabel.text = country.name;
    return cell;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView
        commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
        forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        Country *countryToDelete = [results objectAtIndex:indexPath.row];
        [self.context deleteObject:countryToDelete];
        NSError *error = nil;
        if (![self.context save:&error]) {
            NSLog(@"ERROR ON DELETE");
        }
        [self viewWillAppear:true];
        
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert
        // it into the array, and add a new row to the table view
    }
}



@end
