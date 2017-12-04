#import <UIKit/UIKit.h>
#import "Utils.h"

@interface SportsViewController : UIViewController <GADBannerViewDelegate>
{
    EnumSports sportSelected;
    NSManagedObjectContext *managedObjectContext;
}


@property (weak, nonatomic) IBOutlet UIButton *buttonFootball;
@property (weak, nonatomic) IBOutlet UIButton *buttonBasketball;

@property (weak, nonatomic) IBOutlet UIButton *buttonVolleyball;
@property (weak, nonatomic) IBOutlet UIButton *buttonHandball;

@property (weak, nonatomic) IBOutlet UIButton *buttonHockey;
@property (weak, nonatomic) IBOutlet UIButton *buttonFavorites;

@property (weak, nonatomic) IBOutlet UIButton *actionOpenVolleyball;
@property (weak, nonatomic) IBOutlet UIButton *actionOpenHandball;
@property (weak, nonatomic) IBOutlet UIButton *actionOpenHockey;

- (IBAction)actionOpenSport:(id)sender;
- (IBAction)actionFavorites:(id)sender;

@property(nonatomic, strong) GADBannerView *bannerView;
@property (weak, nonatomic) IBOutlet UIView *viewHostingBanner;

@end
