#import "MyIphoneViewController.h"

@implementation MyIphoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    self.labelName.text = [userDefaults stringForKey:@"name_preference"];
    self.labelEmail.text = [userDefaults stringForKey:@"email_preference"];
    self.labelPhone.text = [userDefaults stringForKey:@"phone_preference"];
    NSString *imageStr = [userDefaults stringForKey:@"image_preference"];
    self.imageViewProfile.image = [UIImage imageNamed:[imageStr stringByAppendingString:@".jpg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
