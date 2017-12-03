#import <UIKit/UIKit.h>
#import "Utils.h"
@import GoogleMobileAds;

@interface CompetitionsTableViewController : UITableViewController
{
    EnumSports sportSelected;
    NSArray *arrayCompetitions;
}
@property EnumSports sportSelected;
@property(nonatomic, strong) GADInterstitial *interstitial;
@end
