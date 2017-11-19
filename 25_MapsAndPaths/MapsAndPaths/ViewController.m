
#import "ViewController.h"

#define EMPTY_STR @""
#define UNDERSCORE_STR @"_"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //start location manager.
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    locationManager.delegate = self; //CLLocationManagerDelegate
    [locationManager startUpdatingLocation];
    //config map
    self.mapView.delegate = self; //MKMapViewDelegate
    self.mapView.showsUserLocation = true;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions
- (IBAction)actionSearchDestination:(id)sender {
    NSString *userInput = ((UITextField*) sender).text;
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:userInput completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error %@", [error localizedDescription]);
        } else {
            if ([placemarks count]>0) {
                selectedLocation = [placemarks lastObject];
                //config map region and add anotation.
                MKCoordinateRegion region;
                region.center.latitude = selectedLocation.location.coordinate.latitude;
                region.center.longitude = selectedLocation.location.coordinate.longitude;
                //un grado es 111kms.
                region.span = MKCoordinateSpanMake(0.05, 0.05);
                [self.mapView setRegion:region];
                [self addDestination: selectedLocation];
            }
        }
    }];
}

- (IBAction)actionCalculatePath:(id)sender {
    MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] init];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:selectedLocation];
    [directionRequest setDestination:[[MKMapItem alloc] initWithPlacemark:placemark]];
    [directionRequest setSource:[MKMapItem mapItemForCurrentLocation]];
    MKDirections *directions = [[MKDirections alloc]initWithRequest:directionRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            routeToDestination = [response.routes lastObject];
            [self.mapView addOverlay:routeToDestination.polyline];
            self.labelAddress.text = [selectedLocation.addressDictionary objectForKey:@"Street"];
            self.labelDistance.text = [NSString stringWithFormat:@"%.2f Kms", routeToDestination.distance/1000];
            self.labelTransport.text = [NSString stringWithFormat:@"%i", routeToDestination.transportType];
            NSString *steps = EMPTY_STR;
            for (MKRouteStep *step in routeToDestination.steps) {
                steps = [steps stringByAppendingString:step.instructions];
                steps = [steps stringByAppendingString:@"\n\n"];
            }
            self.textViewRoute.text = steps;
        }
    }];
}

- (IBAction)actionCleanPath:(id)sender {
    self.textFieldUserAddress.text = EMPTY_STR;
    self.labelAddress.text = UNDERSCORE_STR;
    self.labelDistance.text = UNDERSCORE_STR;
    self.labelTransport.text = UNDERSCORE_STR;
    self.textViewRoute.text = UNDERSCORE_STR;
    [self.mapView removeAnnotation:destinationPointAnnotation];
    [self.mapView removeOverlay:routeToDestination.polyline];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations objectAtIndex:0];
    [self.mapView setCenterCoordinate:location.coordinate animated:true];
}

#pragma mark - MKMapViewDelegate
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *routeRender = [[MKPolylineRenderer alloc] initWithPolyline: overlay];
    routeRender.strokeColor = [UIColor redColor];
    routeRender.lineWidth = 5.0;
    return routeRender;
}

#pragma mark - private methods
-(void) addDestination:(CLPlacemark *) ubication {
    destinationPointAnnotation = [[MKPointAnnotation alloc] init];
    destinationPointAnnotation.coordinate = CLLocationCoordinate2DMake(ubication.location.coordinate.latitude, ubication.location.coordinate.longitude);
    destinationPointAnnotation.title = [ubication.addressDictionary objectForKey:@"Street"];
    destinationPointAnnotation.subtitle = [ubication.addressDictionary objectForKey:@"Street"];
    [self.mapView addAnnotation:destinationPointAnnotation];
}
@end
