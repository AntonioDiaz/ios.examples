#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *arrayTowns;    
}
@property (weak, nonatomic) IBOutlet UITableView *townsTableView;

@end

