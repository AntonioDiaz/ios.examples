#import "ViewController.h"

@interface FormViewController : ViewController
@property (weak, nonatomic) IBOutlet UITextField *textFieldName;
@property (weak, nonatomic) IBOutlet UITextField *textFieldSurname;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedControlGender;
- (IBAction)buttonOk:(id)sender;

@end
