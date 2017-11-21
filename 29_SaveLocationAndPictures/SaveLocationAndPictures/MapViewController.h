#import "ViewController.h"
#import <MapKit/MapKit.h>


@interface MapViewController : ViewController <MKMapViewDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end
