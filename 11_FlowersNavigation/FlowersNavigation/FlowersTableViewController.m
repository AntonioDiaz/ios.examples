//
//  FlowersTableViewController.m
//  FlowersNavigation
//
//  Created by cice on 2/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "FlowersTableViewController.h"
#define FLOWERS_RED @"flowers_red"
#define FLOWERS_BLUE @"flowers_blue"
#define KEY_TITLE @"key_title"
#define KEY_URL @"key_url"
#define KEY_IMAGE @"key_image"


@interface FlowersTableViewController ()

@end

@implementation FlowersTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *flowerRose = [[NSDictionary alloc] initWithObjectsAndKeys:@"Rose", KEY_TITLE, @"https://en.wikipedia.org/wiki/Rose", KEY_URL, @"roja-0.jpg", KEY_IMAGE, nil];
    NSDictionary *flowerPoppy = [[NSDictionary alloc] initWithObjectsAndKeys:@"Poppy", KEY_TITLE, @"https://en.wikipedia.org/wiki/Poppy", KEY_URL, @"roja-1.jpg", KEY_IMAGE, nil];
    NSDictionary *flowerBlue = [[NSDictionary alloc] initWithObjectsAndKeys:@"Iris", KEY_TITLE, @"https://en.wikipedia.org/wiki/Iris", KEY_URL,
        @"azul-0.jpg", KEY_IMAGE, nil];
    NSDictionary *flowerIris = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hyacinth flower", KEY_TITLE, @"https://en.wikipedia.org/wiki/Hyacinth_(plant)", KEY_URL, @"azul-1.jpg", KEY_IMAGE, nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *redFlowers = [[NSArray alloc] initWithObjects: flowerRose, flowerPoppy, nil];
    NSArray *blueFlowers = [[NSArray alloc] initWithObjects: flowerBlue, flowerIris, nil];
    
    flowersDataSource = [[NSDictionary alloc] initWithObjectsAndKeys:redFlowers, FLOWERS_RED, blueFlowers, FLOWERS_BLUE, nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [[flowersDataSource objectForKey:FLOWERS_RED] count];
        case 1:
            return [[flowersDataSource objectForKey:FLOWERS_BLUE] count];
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *flowerDictionary = [self flowerName:indexPath.section withIndex:indexPath.row];
    cell.textLabel.text = [flowerDictionary objectForKey:KEY_TITLE];
    cell.detailTextLabel.text = [flowerDictionary objectForKey:KEY_IMAGE];
    cell.imageView.image = [UIImage imageNamed:[flowerDictionary objectForKey:KEY_IMAGE]];
    return cell;
}

-(NSDictionary *) flowerName:(NSInteger) section withIndex:(NSInteger)index {
    NSArray *flowersArray;
    NSDictionary *flowerDictionary;
    switch (section) {
        case 0:
            flowersArray = [flowersDataSource objectForKey:FLOWERS_RED];
            flowerDictionary = [flowersArray objectAtIndex:index];
            break;
        case 1:
            flowersArray = [flowersDataSource objectForKey:FLOWERS_BLUE];
            flowerDictionary = [flowersArray objectAtIndex:index];
            break;
        default:
            break;
    }
    return flowerDictionary;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
