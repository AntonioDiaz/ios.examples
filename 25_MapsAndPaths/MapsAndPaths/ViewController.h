
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
    CLPlacemark * selectedLocation;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelDistance;
@property (weak, nonatomic) IBOutlet UILabel *labelTransport;
@property (weak, nonatomic) IBOutlet UITextView *textViewRoute;

- (IBAction)actionSearchDestination:(id)sender;
- (IBAction)actionCalculatePath:(id)sender;
- (IBAction)actionCleanPath:(id)sender;

@end
