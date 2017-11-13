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
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
