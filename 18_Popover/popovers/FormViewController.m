#import "FormViewController.h"

@implementation FormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions
- (IBAction)buttonOk:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
    [self.popoverPresentationController.delegate popoverPresentationControllerDidDismissPopover:self.popoverPresentationController];
}

@end
