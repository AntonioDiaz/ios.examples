#import <UIKit/UIKit.h>
#import <Contacts/Contacts.h>
#import <ContactsUI/ContactsUI.h>


@interface ViewController : UIViewController <CNContactPickerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFriend;
@property (weak, nonatomic) IBOutlet UILabel *labelFriendName;
- (IBAction)actionChooseFriend:(id)sender;
- (IBAction)actionShareContact:(id)sender;

@end

