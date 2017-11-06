//
//  FlowersCollectionViewController.m
//  FlowersNavigation
//
//  Created by cice on 3/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "FlowersCollectionViewController.h"
#import "HeaderCollectionReusableView.h"
#import "FooterCollectionReusableView.h"

#define FLOWERS_RED @"flowers_red"
#define FLOWERS_BLUE @"flowers_blue"
#define KEY_TITLE @"key_title"
#define KEY_URL @"key_url"
#define KEY_IMAGE @"key_image"

@interface FlowersCollectionViewController ()

@end

@implementation FlowersCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *flowerRose = [[NSDictionary alloc] initWithObjectsAndKeys:@"Rose", KEY_TITLE, @"https://en.wikipedia.org/wiki/Rose", KEY_URL, @"roja-0.jpg", KEY_IMAGE, nil];
    NSDictionary *flowerPoppy = [[NSDictionary alloc] initWithObjectsAndKeys:@"Poppy", KEY_TITLE, @"https://en.wikipedia.org/wiki/Poppy", KEY_URL, @"roja-1.jpg", KEY_IMAGE, nil];
    
    NSDictionary *flowerPoppy2 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Poppy", KEY_TITLE, @"https://en.wikipedia.org/wiki/Poppy", KEY_URL, @"roja-2.jpg", KEY_IMAGE, nil];

    
    NSDictionary *flowerPoppy3 = [[NSDictionary alloc] initWithObjectsAndKeys:@"Poppy", KEY_TITLE, @"https://en.wikipedia.org/wiki/Poppy", KEY_URL, @"roja-3.jpg", KEY_IMAGE, nil];
    
    NSDictionary *flowerBlue = [[NSDictionary alloc] initWithObjectsAndKeys:@"Iris", KEY_TITLE, @"https://en.wikipedia.org/wiki/Iris", KEY_URL,
                                @"azul-0.jpg", KEY_IMAGE, nil];
    NSDictionary *flowerIris = [[NSDictionary alloc] initWithObjectsAndKeys:@"Hyacinth flower", KEY_TITLE, @"https://en.wikipedia.org/wiki/Hyacinth_(plant)", KEY_URL, @"azul-1.jpg", KEY_IMAGE, nil];
    
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *redFlowers = [[NSMutableArray alloc] initWithObjects: flowerRose, flowerPoppy, flowerPoppy2,flowerPoppy3, nil];
    NSMutableArray *blueFlowers = [[NSMutableArray alloc] initWithObjects: flowerBlue, flowerIris, nil];
    
    flowersDataSource = [[NSDictionary alloc] initWithObjectsAndKeys:redFlowers, FLOWERS_RED, blueFlowers, FLOWERS_BLUE, nil];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    //[self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
    
    
    //section margin
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.sectionInset = UIEdgeInsetsMake(5.0, 0, 0, 5.0);
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [[flowersDataSource objectForKey:FLOWERS_RED] count];
        case 1:
            return [[flowersDataSource objectForKey:FLOWERS_BLUE] count];
        default:
            return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSDictionary *flowerDictionary = [self flowerName:indexPath.section withIndex:indexPath.row];
    
    NSString *imageString = [flowerDictionary objectForKey:KEY_IMAGE];
    UIImageView *imageView = (UIImageView *) [cell viewWithTag:100];
    imageView.image = [UIImage imageNamed:imageString];
    NSLog(@"pasa %@", imageString);
    NSLog(@" cell position: %f, %f", cell.frame.origin.x, cell.frame.origin.y);
    NSLog(@" cell size: %f, %f", cell.frame.size.height, cell.frame.size.width);
    return cell;
}

-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
   
    if (kind == UICollectionElementKindSectionHeader) {
        HeaderCollectionReusableView *headerReusableView;
        headerReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId" forIndexPath:indexPath];
        headerReusableView.label.text = (indexPath.section == 0)?@"Red flowers":@"Blue flowers";
        headerReusableView.headerImage.image = [UIImage imageNamed:@"tab_bar_background.png"];
        return headerReusableView;
    }
    if (kind == UICollectionElementKindSectionFooter) {
        FooterCollectionReusableView *footerReusableView;
        footerReusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerId" forIndexPath:indexPath];
        footerReusableView.label.text = (indexPath.section == 0)?@"Foot: Red flowers":@"Foot: Blue flowers";
        return footerReusableView;
    }
    return nil;
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


#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
