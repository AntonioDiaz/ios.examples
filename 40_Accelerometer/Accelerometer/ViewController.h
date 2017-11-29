#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>


@interface ViewController : UIViewController


@property (nonatomic, strong) CMMotionManager *motionManager;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBall;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTree;



@property (weak, nonatomic) IBOutlet UILabel *axisX;
@property (weak, nonatomic) IBOutlet UILabel *axisY;
@property (weak, nonatomic) IBOutlet UILabel *axisZ;



@end

