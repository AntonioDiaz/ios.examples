#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>


@interface EventTableViewController : UITableViewController
{
    EKEventStore *eventStore;
    NSArray *arrayEvents;
}
@end
