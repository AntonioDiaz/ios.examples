//
//  FinderTableViewController.m
//  FinderFlowersNavigator
//
//  Created by cice on 8/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "FinderTableViewController.h"
#import "FinderTableViewController.h"
#import "ViewAnimation.h"

#define FLOWERS_RED @"flowers_red"
#define FLOWERS_BLUE @"flowers_blue"
#define KEY_TITLE @"key_title"
#define KEY_URL @"key_url"
#define KEY_IMAGE @"key_image"

@interface FinderTableViewController ()

@end

@implementation FinderTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSDictionary *flowerRose = [[NSDictionary alloc] initWithObjectsAndKeys:@"Rose", KEY_TITLE, @"https://en.wikipedia.org/wiki/Rose", KEY_URL, @"roja-0.jpg", KEY_IMAGE, nil];
    NSDictionary *flowerPoppy = [[NSDictionary alloc] initWithObjectsAndKeys:@"Poppy", KEY_TITLE, @"https://en.wikipedia.org/wiki/Poppy", KEY_URL, @"roja-1.jpg", KEY_IMAGE, nil];
    
    NSDictionary *flowerPoppy2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Poppy2", KEY_TITLE, @"https://en.wikipedia.org/wiki/Poppy", KEY_URL, @"roja-2.jpg", KEY_IMAGE, nil];
    
    NSDictionary *flowerBlue = [[NSDictionary alloc] initWithObjectsAndKeys:@"Iris", KEY_TITLE, @"https://en.wikipedia.org/wiki/Iris", KEY_URL,
                                @"azul-0.jpg", KEY_IMAGE, nil];
    NSDictionary *flowerIris = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hyacinth flower", KEY_TITLE, @"https://en.wikipedia.org/wiki/Hyacinth_(plant)", KEY_URL, @"azul-1.jpg", KEY_IMAGE, nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    allFlowersArray = [[NSMutableArray alloc] initWithObjects: flowerBlue, flowerIris, flowerRose, flowerPoppy, flowerPoppy2, nil];
    flowersShown = allFlowersArray;
    searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    searchController.searchResultsUpdater = self;
    searchController.searchBar.delegate = self;
    [searchController.searchBar sizeToFit];
    
    self.tableView.tableHeaderView = searchController.searchBar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [flowersShown count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *flowerDictionary = [flowersShown objectAtIndex:indexPath.row];
    NSString *flowerName = [flowerDictionary objectForKey:KEY_TITLE];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = flowerName;
    cell.detailTextLabel.text = flowerName;
    return cell;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueShowFlowerDetail"]) {
        self.navigationController.delegate = self;
    }
}

- (void)updateSearchResultsForSearchController:(nonnull UISearchController *)searchController {
    NSLog(@"searchController --> %@", searchController.searchBar.text);
    [self filterFlowers:searchController.searchBar.text];
}

#pragma mark - Navigation
-(void)filterFlowers:(NSString *) filterFlowerText {
    if ([filterFlowerText isEqualToString:@""]) {
        flowersShown = allFlowersArray;
    } else {
        flowersShown = [[NSMutableArray alloc] init];
        /*
        for (NSDictionary *dictionaryFlower in allFlowersArray) {
            NSString* flowerName = [dictionaryFlower objectForKey:KEY_TITLE];
            if([flowerName localizedCaseInsensitiveContainsString:filterFlowerText]) {
                [flowersSearch addObject:dictionaryFlower];
            }
        }
         */
        NSPredicate *predicateSearch = [NSPredicate predicateWithFormat:@"key_title contains[c] %@", filterFlowerText];
        flowersShown = [[allFlowersArray filteredArrayUsingPredicate:predicateSearch] mutableCopy];
    }
    [self.tableView reloadData];
}

#pragma mark - UINavigationControllerDelegate
-(id<UIViewControllerAnimatedTransitioning>)
        navigationController:(UINavigationController *)navigationController
        animationControllerForOperation:(UINavigationControllerOperation)operation
        fromViewController:(UIViewController *)fromVC
        toViewController:(UIViewController *)toVC {
    NSLog(@"UINavigationControllerDelegate");
    
    ViewAnimation *viewAnimation = [ViewAnimation new];
    return viewAnimation;
}

@end
