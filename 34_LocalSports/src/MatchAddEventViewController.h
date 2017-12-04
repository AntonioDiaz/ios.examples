#import <UIKit/UIKit.h>
#import "MatchEntity+CoreDataProperties.h"
#import <EventKit/EventKit.h>


@interface MatchAddEventViewController : UIViewController {
    MatchEntity *matchEntity;
    EKEventStore *eventStore;
}
@property MatchEntity *matchEntity;
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelPlace;


- (IBAction)actionAddEvent:(id)sender;

@end
