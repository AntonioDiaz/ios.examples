#import <UIKit/UIKit.h>
#import "MatchEntity+CoreDataProperties.h"

@interface CalendarTableViewController : UITableViewController
{
    NSArray *arrayMatches;
}

-(void) reloadDataTable;

@end
