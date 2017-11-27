
#import <UIKit/UIKit.h>

@interface FlashLightViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *viewLight;
@property (weak, nonatomic) IBOutlet UISwitch *switchLight;
@property (weak, nonatomic) IBOutlet UISlider *sliderLight;

- (IBAction)savePreferences:(id)sender;
- (IBAction)actionChangeLight:(id)sender;

@end
