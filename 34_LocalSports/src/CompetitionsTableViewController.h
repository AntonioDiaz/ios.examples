#import <UIKit/UIKit.h>
#import "Utils.h"

@interface CompetitionsTableViewController : UITableViewController
{
    EnumSports sportSelected;
    NSArray *arrayCompetitions;
}
@property EnumSports sportSelected;
@end
