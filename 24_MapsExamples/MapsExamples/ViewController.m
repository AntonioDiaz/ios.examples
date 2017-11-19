#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestAlwaysAuthorization];
    //CLLocationManagerDelegate
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    //gps precision
    locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    //
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
    self.mapView.userLocation.title = @"Here I am";
    self.mapView.userLocation.subtitle = @"This is Antoine";
    MKPointAnnotation *pointLope = [self generateAnnotation:40.3204539 withLongitude:-3.7749351 withTitle:@"Lope de Vega" withSubtitle:@"Public School"];
    MKPointAnnotation *pointSevero = [self generateAnnotation:40.3193087 withLongitude:-3.7725426 withTitle:@"Servero Ochoa" withSubtitle:@"Public Hospital"];
    MKPointAnnotation *pointUc3m = [self generateAnnotation:40.3310872 withLongitude:-3.7685294 withTitle:@"UC3M" withSubtitle:@"Public University"];

    [self.mapView addAnnotation:pointLope];
    [self.mapView addAnnotation:pointSevero];
    [self.mapView addAnnotation:pointUc3m];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations objectAtIndex:0];
    [self.mapView setCenterCoordinate:location.coordinate animated:true];
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
            UIImage *image = [UIImage imageNamed:@"monument.png"];
            image = [ViewController imageWithImage:image scatedToSize:CGSizeMake(20, 20)];
            annotationView.image = image;
            
            //boton de la derecha del bocadillo.
            UIButton *buttonRight = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
            [buttonRight addTarget:self action:@selector(clickPin:) forControlEvents:UIControlEventTouchUpInside];
            annotationView.rightCalloutAccessoryView = buttonRight;
            //imagen izq en el bocadillo.
            UIImage *imageLeft = [UIImage imageNamed:@"monument.png"];
            imageLeft = [ViewController imageWithImage:imageLeft scatedToSize:CGSizeMake(20, 20)];
            UIImageView *imageView = [[UIImageView alloc] initWithImage:imageLeft];
            
            annotationView.leftCalloutAccessoryView = imageView;
            
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    return nil;
}

#pragma mark - private methods
-(MKPointAnnotation*) generateAnnotation:(CLLocationDegrees) latitude
                           withLongitude:(CLLocationDegrees) longitude
                               withTitle:(NSString *) title
                            withSubtitle:(NSString *) subTitle {
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    pointAnnotation.title = title;
    pointAnnotation.subtitle = subTitle;
    return pointAnnotation;
}

-(void)clickPin:(id)sender {
    NSLog(@"click on monument");
}

#pragma mark - static methods
+ (UIImage *) imageWithImage:(UIImage *) image scatedToSize:(CGSize) newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
