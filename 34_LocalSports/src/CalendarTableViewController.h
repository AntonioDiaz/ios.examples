#import <UIKit/UIKit.h>
#import "MatchEntity+CoreDataProperties.h"

@interface CalendarTableViewController : UITableViewController
{
    NSArray *arrayMatches;
    NSMutableIndexSet *sectionsExpanded;
    int numOfWeeks;
    int numMatchesEachWeek;
}

-(void) reloadDataTable:(CompetitionEntity *) competition;

@end
