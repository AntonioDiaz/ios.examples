#import <UIKit/UIKit.h>
#import "CompetitionEntity+CoreDataProperties.h"

@interface ClassificationTableViewController : UITableViewController
{
    NSArray *arrayClassification;
}
-(void) reloadDataTable:(CompetitionEntity *) competition;
@end
