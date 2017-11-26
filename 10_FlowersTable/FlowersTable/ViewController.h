#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate, UIActionSheetDelegate>
{
    NSDictionary *flowersDataSource;
}

@property (weak, nonatomic) IBOutlet UITableView *tableFlowers;


@end

