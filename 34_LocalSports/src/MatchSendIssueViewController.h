#import <UIKit/UIKit.h>
#import "MatchEntity+CoreDataProperties.h"

@interface MatchSendIssueViewController : UIViewController {
    MatchEntity *matchEntity;
}

@property MatchEntity *matchEntity;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDate;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPlace;
@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;

- (IBAction)actionSendIssue:(id)sender;

@end
