#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelFriendName.text = @"";
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
    NSArray *contents = @[self.labelFriendName.text];
    UIActivityViewController *controller = [[UIActivityViewController alloc] initWithActivityItems:contents applicationActivities:nil];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    
    UIPopoverPresentationController *popController = [controller popoverPresentationController];
    popController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    popController.sourceView = sender;
    //popController.arrowDirection = UIPopoverArrowDirectionUp;
    
    NSArray *excluded = [[NSArray alloc] initWithObjects:UIActivityTypeAirDrop, nil];
    //controller.excludedActivityTypes= excluded;
    
    //popController.sourceRect = ((UIButton *) sender).bounds;
    //popController.sourceRect = CGRectMake(0, 0, 305, 82);
    
    
    [self presentViewController:controller animated:YES completion:nil];
    controller.completionWithItemsHandler = ^(NSString *activityType,
                                              BOOL completed,
                                              NSArray *returnedItems,
                                              NSError *error){
        // react to the completion
        if (completed) {
            
            // user shared an item
            NSLog(@"We used activity type%@", activityType);
            
        } else {
            
            // user cancelled
            NSLog(@"We didn't want to share anything after all.");
        }
        
        if (error) {
            NSLog(@"An Error occured: %@, %@", error.localizedDescription, error.localizedFailureReason);
        }
    };
    /**
    [activityViewController setModalPresentationStyle:UIModalPresentationPopover];
    UIPopoverPresentationController *popOverPresentionController = [activityViewController popoverPresentationController];
    popOverPresentionController.sourceView = sender;
    popOverPresentionController.sourceRect = ((UIButton *) sender).frame;
    popOverPresentionController.permittedArrowDirections = UIPopoverArrowDirectionAny;
    [self presentViewController:activityViewController animated:true completion:nil];
    
    //NSArray *excluded = [[NSArray alloc] initWithObjects:UIActivityTypePrint, nil];
    //activityViewController.excludedActivityTypes= excluded;
    */
}

#pragma mark -CNContactPickerDelegate
-(void) contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact {
    [self dismissViewControllerAnimated:true completion:nil];
    self.labelFriendName.text = [NSString stringWithFormat:@"%@, %@", contact.familyName, contact.givenName ];
    self.imageViewFriend.image =  [UIImage imageWithData:contact.imageData];
}

@end
