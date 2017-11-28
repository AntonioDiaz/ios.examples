#import "CompetitionsViewController.h"

@implementation CompetitionsViewController

@synthesize sportSelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ - %d", APP_NAME, sportSelected];
    //https://localsports-web.appspot.com/server/search_competitions?idTown=6318635089920000
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
