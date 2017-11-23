#import <UIKit/UIKit.h>

@interface AddProductyViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, NSURLSessionDelegate>
{
    NSArray *categoriesArray;
    UIImage *selectedImage;
    
}

@property (weak, nonatomic) IBOutlet UITextField *textViewName;
@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewCategory;
@property (weak, nonatomic) IBOutlet UIButton *buttonCamera;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProduct;
- (IBAction)actionChooseImageCamera:(id)sender;
- (IBAction)actionChooseImageGallery:(id)sender;
- (IBAction)actionSave:(id)sender;
- (IBAction)actionCancel:(id)sender;
- (IBAction)downloadImage:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *progressBar;

@end
