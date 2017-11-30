#import <UIKit/UIKit.h>
#import "MatchEntity+CoreDataProperties.h"
#import <EventKit/EventKit.h>


@interface MatchAddEventViewController : UIViewController {
    MatchEntity *matchEntity;
    EKEventStore *eventStore;
}
@property MatchEntity *matchEntity;
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDate;
@property (weak, nonatomic) IBOutlet UITextField *textFieldPlace;

- (IBAction)actionAddEvent:(id)sender;

@end
