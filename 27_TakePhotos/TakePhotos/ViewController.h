#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *buttonCamera;
- (IBAction)actionLibrary:(id)sender;
- (IBAction)actionCamera:(id)sender;

@end

