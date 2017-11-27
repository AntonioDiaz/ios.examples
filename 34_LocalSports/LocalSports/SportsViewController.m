#import "SportsViewController.h"
#import "CategoriesViewController.h"

@interface SportsViewController ()

@end

@implementation SportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    
    UITapGestureRecognizer *singleTapFootball = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetectedFootball)];
    singleTapFootball.numberOfTapsRequired = 1;
    [self.imageViewFootball setUserInteractionEnabled:YES];
    [self.imageViewFootball addGestureRecognizer:singleTapFootball];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)tapDetectedFootball{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    CategoriesViewController *categoriesViewController = [storyboard instantiateViewControllerWithIdentifier:@"idCategoriesViewController"];
    categoriesViewController.sportSelected = @"FOOTBALL";
    [self presentViewController:categoriesViewController animated:YES completion:nil];
    
    [self.buttonFavorites.imageView setContentMode:UIViewContentModeScaleAspectFit];
    
    //self.buttonFavorites.imageView.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentFill;
    //self.buttonFavorites.imageView.contentVerticalAlignment =  UIControlContentVerticalAlignmentFill;
    self.buttonFavorites.imageView.contentMode =  UIViewContentModeScaleAspectFill;
    
    
    
}

-(void)tapDetectedBasketball{
    NSLog(@"single Tap on imageview");
}

-(void)tapDetectedHandball{
    NSLog(@"single Tap on imageview");
}

-(void)tapDetectedVolleyball{
    NSLog(@"single Tap on imageview");
}

-(void)tapDetectedHockey{
    NSLog(@"single Tap on imageview");
}

-(void)tapDetectedFavorites{
    NSLog(@"single Tap on imageview");
}

@end
