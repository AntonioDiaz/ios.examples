#import "MatchMapViewController.h"

@implementation MatchMapViewController

@synthesize sportCenter;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"SportCenter location";
    self.labelAddress.text = sportCenter.centerName;
    self.labelAddress.text = sportCenter.centerAddress;
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = 30;
    CLLocation *location = [[CLLocation alloc]
                            initWithLatitude:locationManager.location.coordinate.latitude
                            longitude:locationManager.location.coordinate.longitude];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000);
    [self.mapView setRegion:region];
    //MKMapViewDelegate
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsScale = true;
    self.mapView.showsCompass = true;
    self.mapView.zoomEnabled = true;
    //user location
    self.mapView.showsUserLocation = true;
    
    
    MKPointAnnotation *pointUc3m = [self generateAnnotation:40.3310872 withLongitude:-3.7685294 withTitle:@"UC3M" withSubtitle:@"Public University"];
    [self.mapView addAnnotation:pointUc3m];
    
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - MKMapViewDelegate
-(MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //to change the location blue point.
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        //to change the location red point.
    } else if ([annotation isKindOfClass:[MKPointAnnotation class]]) {
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapPin"];
        if (!annotationView) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapPin"];
            annotationView.canShowCallout = true;
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    return nil;
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations objectAtIndex:0];
    [self.mapView setCenterCoordinate:location.coordinate animated:true];
}


#pragma mark - private methods
-(MKPointAnnotation*) generateAnnotation:(CLLocationDegrees) latitude
                           withLongitude:(CLLocationDegrees) longitude
                               withTitle:(NSString *) title
                            withSubtitle:(NSString *) subTitle {
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    pointAnnotation.title = title;
    pointAnnotation.subtitle = subTitle;
    return pointAnnotation;
}

#pragma mark - static methods
+ (UIImage *) imageWithImage:(UIImage *) image scatedToSize:(CGSize) newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

-(CLLocationCoordinate2D) getLocationFromAddressString: (NSString*) addressStr {
    double latitude = 0, longitude = 0;
    NSString *esc_addr =  [addressStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    if (result) {
        NSScanner *scanner = [NSScanner scannerWithString:result];
        if ([scanner scanUpToString:@"\"lat\" :" intoString:nil] && [scanner scanString:@"\"lat\" :" intoString:nil]) {
            [scanner scanDouble:&latitude];
            if ([scanner scanUpToString:@"\"lng\" :" intoString:nil] && [scanner scanString:@"\"lng\" :" intoString:nil]) {
                [scanner scanDouble:&longitude];
            }
        }
    }
    CLLocationCoordinate2D center;
    center.latitude=latitude;
    center.longitude = longitude;
    NSLog(@"View Controller get Location Logitute : %f",center.latitude);
    NSLog(@"View Controller get Location Latitute : %f",center.longitude);
    return center;
    
}

@end
