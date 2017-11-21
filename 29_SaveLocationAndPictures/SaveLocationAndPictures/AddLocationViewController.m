#import "AddLocationViewController.h"
#import "AppDelegate.h"
#import "LocationEntity+CoreDataProperties.h"
#import <MapKit/MapKit.h>

@interface AddLocationViewController ()

@end

@implementation AddLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (![UIImagePickerController
          isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.buttonCamera.enabled = false;
    }
    //config locationmanager
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    locationManager.delegate = self;
    locationManager.distanceFilter = 30;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - actions
- (IBAction)actionLibrary:(id)sender {
    [self takePicture:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)actionCamera:(id)sender {
    [self takePicture:UIImagePickerControllerSourceTypeCamera];
}

//save new picture and location in db
- (IBAction)actionSaveLocation:(id)sender {
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = app.persistentContainer.viewContext;
    NSString *titleStr =  self.textViewTitle.text;
    LocationEntity *locationEntity = [NSEntityDescription insertNewObjectForEntityForName:@"LocationEntity" inManagedObjectContext:managedObjectContext];
    locationEntity.title = titleStr;
    locationEntity.latitude = [NSString stringWithFormat:@"%1.9f", locationManager.location.coordinate.latitude];
    locationEntity.longitude = [NSString stringWithFormat:@"%1.9f", locationManager.location.coordinate.longitude];
    
    NSString *documentsDirectoryPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSLog(@"documentDirectory: %@", documentsDirectoryPath);
    //get image data.
    NSData *imageData = UIImagePNGRepresentation(self.imageViewLocation.image);
    NSError *error;
    NSString *imageName = [NSString stringWithFormat:@"%@/%@.jpg", documentsDirectoryPath, titleStr];
    
    locationEntity.image = imageName;
    [imageData writeToFile:imageName options:NSDataWritingAtomic error:&error];
    
    [managedObjectContext save:&error];
    if (error!=nil) {
        NSLog(@"save error %@", error.localizedDescription);
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save"
                                                            message:@"Save finished" delegate:self cancelButtonTitle:@"Accept"
                                                  otherButtonTitles:nil, nil];
        [alertView show];

    }
    
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    //location = [locations objectAtIndex:0];
    NSLog(@"change locatio....");
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
    self.imageViewLocation.image = image;
    [picker dismissViewControllerAnimated:true completion:nil];
    
    
    //float finalHeight = self.imageView.frame.size.width * image.size.height / image.size.width;
    //CGRect imageFrame = CGRectMake(self.imageView.frame.origin.x, self.imageView.frame.origin.y, self.imageView.frame.size.width, finalHeight);
    //self.imageView.frame = imageFrame;
    
    
}

@end
