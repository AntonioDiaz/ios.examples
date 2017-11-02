//
//  ViewController.m
//  FlowersTable
//
//  Created by cice on 31/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"
#define FLOWERS_RED @"red_flowers"
#define FLOWERS_BLUE @"blue_flowers"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *redFlowers = [[NSArray alloc] initWithObjects:@"Rosa", @"Amapola", @"Gerbera", @"Peony", nil];
    NSArray *blueFlowers = [[NSArray alloc] initWithObjects:@"Jacinto", @"Acebo de mar", @"Iris", @"Flox", nil];
    
    flowersDataSource = [[NSDictionary alloc] initWithObjectsAndKeys:redFlowers, FLOWERS_RED, blueFlowers, FLOWERS_BLUE, nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark DataSource methods.
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [[flowersDataSource objectForKey:FLOWERS_RED] count];
        case 1:
            return [[flowersDataSource objectForKey:FLOWERS_BLUE] count];
        default:
            return 0;
    }
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Red Flowers";
        case 1:
            return @"Blue Flowers";
        default:
            return 0;
    }
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSString *name = [self flowerName:indexPath.section withIndex:indexPath.row];
    cell.textLabel.text = name;
    cell.detailTextLabel.text = name;
    return cell;
}

#pragma mark Delegate methods.
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *flowerName = [self flowerName:indexPath.section withIndex:indexPath.row];
    /*
     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:flowerName
        message:flowerName delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Guardar", @"Borrar", nil];
    [alertView show];
     */
    UIActionSheet *actions = [[UIActionSheet alloc] initWithTitle:@"Chose Flower" delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:@"Delete" otherButtonTitles:@"Facebook", @"Twitter", @"Email", nil];
    [actions showInView:self.view];
    
}

-(NSString *) flowerName:(NSInteger) section withIndex:(NSInteger)myIndex {
    NSString *flowerValue;
    NSArray *flowersArray;
    switch (section) {
        case 0:
            flowersArray = [flowersDataSource objectForKey:FLOWERS_RED];
            flowerValue = [flowersArray  objectAtIndex:myIndex];
            break;
        case 1:
            flowersArray = [flowersDataSource objectForKey:FLOWERS_BLUE];
            flowerValue = [flowersArray objectAtIndex:myIndex];
            break;
        default:
            break;
    }
    return flowerValue;
}

#pragma mark UIAlertViewDelegate methods
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *clickedButton = [alertView buttonTitleAtIndex:buttonIndex];
    NSLog(@"Button %@", clickedButton);
}

#pragma mark UIActionSheetDelegate methods
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *clickedButton = [actionSheet buttonTitleAtIndex:buttonIndex];
    NSLog(@"Button %@", clickedButton);
}


@end
