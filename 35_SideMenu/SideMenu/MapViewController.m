
#import "MapViewController.h"

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    SWRevealViewController * swReveal = self.revealViewController;
    if (swReveal) {
        //when click on button open menu.
        [self.itemMenu setTarget:swReveal];
        [self.itemMenu setAction:@selector(revealToggle:)];
        //close menu on move izq/right gesture.
        [self.view addGestureRecognizer:swReveal.panGestureRecognizer];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
