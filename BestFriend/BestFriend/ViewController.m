#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions
- (IBAction)actionChooseFriend:(id)sender {
    CNContactPickerViewController *contactPickerViewController = [[CNContactPickerViewController alloc] init];
    contactPickerViewController.delegate = self;
    [self presentViewController:contactPickerViewController animated:true completion:nil];
}

- (IBAction)actionShareContact:(id)sender {
    
    NSArray *contents = [[NSArray alloc] initWithObjects:self.labelFriendName.text, nil];
    
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:contents applicationActivities:nil];
    
    
    [activityViewController setModalPresentationStyle:UIModalPresentationPopover];
    UIPopoverPresentationController *popOverPresentionController = [activityViewController popoverPresentationController];
    popOverPresentionController.sourceView = sender;
    popOverPresentionController.sourceRect = ((UIButton *) sender).frame;
    [self presentViewController:activityViewController animated:true completion:nil];
    
    NSArray *excluded = [[NSArray alloc] initWithObjects:UIActivityTypePrint, nil];
    activityViewController.excludedActivityTypes= excluded;
    
}

#pragma mark -CNContactPickerDelegate
-(void) contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    [self dismissViewControllerAnimated:true completion:nil];
    self.labelFriendName.text = contact.givenName;
    self.imageViewFriend.image =  [UIImage imageWithData:contact.imageData];
}

@end
