#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BcnViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
{
     CLLocationManager *locationManager;
    NSDictionary *infoStation;
}

@property(nonatomic, retain) NSString *idMetroStation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

