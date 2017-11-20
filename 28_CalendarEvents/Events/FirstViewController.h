#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>

@interface FirstViewController : UIViewController
{
    EKEventStore *eventStore;
}
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerEvent;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLength;
- (IBAction)actionSaveEvent:(id)sender;
- (IBAction)actionHideKeyboard:(id)sender;

@end

