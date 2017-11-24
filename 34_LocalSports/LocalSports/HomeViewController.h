#import <UIKit/UIKit.h>
#import "TownTableView.h"

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *arrayTowns;
    
}
@property (weak, nonatomic) IBOutlet TownTableView *townsTableView;


@end

