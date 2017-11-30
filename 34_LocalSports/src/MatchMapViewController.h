#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "SportCourtEntity+CoreDataProperties.h"

@interface MatchMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}

@property SportCourtEntity *sportCenter;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *labelSportCenterName;
@property (weak, nonatomic) IBOutlet UILabel *labelAddress;

@end
