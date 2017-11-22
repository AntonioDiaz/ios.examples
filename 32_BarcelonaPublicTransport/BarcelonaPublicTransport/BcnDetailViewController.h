#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface BcnDetailViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
{
     CLLocationManager *locationManager;
    NSDictionary *infoStation;
}

@property(nonatomic, retain) NSString *idMetroStation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *labelName;
@property (weak, nonatomic) IBOutlet UILabel *labelLine;
@property (weak, nonatomic) IBOutlet UILabel *labelCoordinates;

@end

