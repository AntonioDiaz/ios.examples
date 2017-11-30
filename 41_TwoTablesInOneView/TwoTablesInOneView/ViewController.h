#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *arrayTimes;
    NSMutableArray *arrayDays;
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableViewTimes;
@property (weak, nonatomic) IBOutlet UITableView *tableViewDays;

- (IBAction)actionAddTime:(id)sender;
- (IBAction)actionAddDay:(id)sender;

@end

