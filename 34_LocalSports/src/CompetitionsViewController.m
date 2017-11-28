#import "CompetitionsViewController.h"

@implementation CompetitionsViewController

@synthesize sportSelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *townSelected = [userDefaults objectForKey:PREF_TOWN_NAME];

    NSString *sportStr = [Utils enumSportToString:sportSelected];
    
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@ - %@", townSelected, sportStr];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
