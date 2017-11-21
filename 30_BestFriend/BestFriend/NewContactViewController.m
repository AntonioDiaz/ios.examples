
#import "NewContactViewController.h"

@implementation NewContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (IBAction)actionSave:(id)sender {
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *alertTitle = @"no access contact";
                NSString *alertSubtitle = @"give me access, plis";
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:alertTitle message:alertSubtitle preferredStyle:UIAlertControllerStyleAlert];
                NSString *titlePermit = @"Permision";
                [alertController addAction:[UIAlertAction actionWithTitle:titlePermit style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    NSURL *nurl = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    NSDictionary *dictionary = [[NSDictionary alloc] init];
                    [[UIApplication sharedApplication] openURL:nurl options:dictionary completionHandler:nil];
                }]];
                [self presentViewController:alertController animated:true completion:nil];
            });
        } else {
            CNMutableContact *newContact = [[CNMutableContact alloc] init];
            CNLabeledValue *labeledValuePhone = [CNLabeledValue labeledValueWithLabel:CNLabelHome value:[CNPhoneNumber phoneNumberWithStringValue:self.textFieldPhone.text]];
            newContact.givenName = self.textFieldName.text;
            newContact.phoneNumbers = [[NSArray alloc] initWithObjects:labeledValuePhone, nil];
            
            
            CNSaveRequest *saveRequest = [[CNSaveRequest alloc] init];
            [saveRequest addContact:newContact toContainerWithIdentifier:nil];
            
            NSError *saveError;
            [contactStore executeSaveRequest:saveRequest error:&saveError];
            if (!saveError) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"save"
                                                                    message:@"save ok" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];

                [alertView show];

            } else {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"save"
                                                                    message:@"save error" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
                
                [alertView show];
            }
        }
    }];
    
    
}
@end
