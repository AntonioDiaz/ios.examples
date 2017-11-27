#import "SportsViewController.h"
#import "CategoriesViewController.h"
#import "Constants.h"

@implementation SportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *townSelected = [userDefaults objectForKey:PREF_TOWN_SELECTED];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ - %@", APP_NAME, townSelected];
    [self.buttonFootball setContentMode:UIViewContentModeCenter];
    [self.buttonFootball.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.buttonBasketball setContentMode:UIViewContentModeCenter];
    [self.buttonBasketball.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.buttonHandball setContentMode:UIViewContentModeCenter];
    [self.buttonHandball.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.buttonVolleyball setContentMode:UIViewContentModeCenter];
    [self.buttonVolleyball.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.buttonHockey setContentMode:UIViewContentModeCenter];
    [self.buttonHockey.imageView setContentMode:UIViewContentModeScaleAspectFit];
    [self.buttonFavorites setContentMode:UIViewContentModeCenter];
    [self.buttonFavorites.imageView setContentMode:UIViewContentModeScaleAspectFit];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods



#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];

}

- (IBAction)actionOpenFootball:(id)sender {
}

- (IBAction)actionOpenBasket:(id)sender {
}

- (IBAction)openSports:(id)sender {
}
@end
