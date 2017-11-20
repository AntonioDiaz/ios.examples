#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //ask if we have access to camera.
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.buttonCamera.enabled = false;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions
- (IBAction)actionLibrary:(id)sender {
    [self takePicture:UIImagePickerControllerSourceTypePhotoLibrary];

}
- (IBAction)actionCamera:(id)sender {
    [self takePicture:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark - private methods
-(void) takePicture:(UIImagePickerControllerSourceType) sourceType {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:true completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(nonnull UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    self.imageView.image = image;
    [picker dismissViewControllerAnimated:true completion:nil];
    
    
    //float finalHeight = self.imageView.frame.size.width * image.size.height / image.size.width;
    //CGRect imageFrame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.frame.size.width, finalHeight);
    //self.imageView.frame = imageFrame;
    
    
}

@end
