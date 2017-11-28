#import <UIKit/UIKit.h>
#import "Constants.h"

@interface SportsViewController : UIViewController
{
    Sport sportSelected;
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

@end
