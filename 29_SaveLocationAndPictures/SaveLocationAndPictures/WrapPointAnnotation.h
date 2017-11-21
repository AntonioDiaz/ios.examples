
#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface WrapPointAnnotation : MKPointAnnotation {
    CLLocationManager *locatioManager;
    
}

@property (nonatomic,retain) UIImage *image;

@end
