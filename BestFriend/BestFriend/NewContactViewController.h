#import "ViewController.h"
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>

@interface NewContactViewController : ViewController <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPhone;
- (IBAction)actionSave:(id)sender;

@end
