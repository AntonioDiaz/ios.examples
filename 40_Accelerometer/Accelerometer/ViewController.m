#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.motionManager = [[CMMotionManager alloc] init];
    self.motionManager.accelerometerUpdateInterval = 0.2;
    //metodo para actualiza el valor.
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData * _Nullable accelerometerData, NSError * _Nullable error) {
        if (!error) {
            self.axisX.text = [NSString stringWithFormat:@"%1.2f", accelerometerData.acceleration.x];
            self.axisY.text = [NSString stringWithFormat:@"%1.2f", accelerometerData.acceleration.y];
            self.axisZ.text = [NSString stringWithFormat:@"%1.2f", accelerometerData.acceleration.z];

            
            self.imageViewBall.frame = CGRectMake(self.imageViewBall.frame.origin.x + (accelerometerData.acceleration.x * 10), self.imageViewBall.frame.origin.y - (accelerometerData.acceleration.x * 10), self.imageViewBall.frame.size.width, self.imageViewBall.frame.size.height);
            
            //keep tree vertical
            self.imageViewTree.transform = CGAffineTransformMakeRotation(atan2(accelerometerData.acceleration.x, accelerometerData.acceleration.y) - M_PI );
            
            
        } else {
            NSLog(@"Error on accelerometer.");
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
