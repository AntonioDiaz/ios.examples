
#import <UIKit/UIKit.h>
#import "Country+CoreDataProperties.h"

@interface CitiesTableViewController : UITableViewController<UIPopoverPresentationControllerDelegate>
{
    NSMutableArray *citiesArray;
}
@property (strong, nonatomic) Country *country;

@end
