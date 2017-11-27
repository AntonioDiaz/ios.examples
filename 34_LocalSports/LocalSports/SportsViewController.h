#import <UIKit/UIKit.h>

@interface SportsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *buttonFootball;
@property (weak, nonatomic) IBOutlet UIButton *buttonBasketball;

@property (weak, nonatomic) IBOutlet UIButton *buttonVolleyball;
@property (weak, nonatomic) IBOutlet UIButton *buttonHandball;

@property (weak, nonatomic) IBOutlet UIButton *buttonHockey;
@property (weak, nonatomic) IBOutlet UIButton *buttonFavorites;
- (IBAction)actionOpenFootball:(id)sender;
- (IBAction)actionOpenBasket:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *actionOpenVolleyball;
@property (weak, nonatomic) IBOutlet UIButton *actionOpenHandball;
@property (weak, nonatomic) IBOutlet UIButton *actionOpenHockey;




@end
