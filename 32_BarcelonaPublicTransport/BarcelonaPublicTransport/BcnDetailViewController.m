#import "BcnDetailViewController.h"
#define URL_API_BCN @"http://barcelonaapi.marcpous.com/metro/station/id/%@.json"

@implementation BcnDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //config locationManager
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    locationManager.delegate = self; //CLLocationManagerDelegate
    locationManager.distanceFilter = 30;
    [locationManager startUpdatingLocation];
    //config mapView
    self.mapView.delegate = self; //MKMapViewDelegate
    //create region
    CLLocation *location = [[CLLocation alloc]
                            initWithLatitude:locationManager.location.coordinate.latitude
                            longitude:locationManager.location.coordinate.longitude];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000);
    [self.mapView setRegion:region];
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsScale = true;
    self.mapView.showsCompass = true;
    self.mapView.zoomEnabled = true;
    self.mapView.showsUserLocation = true;
    
    self.labelName.text = @"-";
    self.labelLine.text = @"-";
    self.labelCoordinates.text = @"-";
    
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config];
    NSString *urlStr = [NSString stringWithFormat:URL_API_BCN, self.idMetroStation];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLSessionTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error on task: %@", error.description);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (httpResponse.statusCode == 200) {
                NSError *jsonError = nil;
                NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                infoStation = [[jsonResults objectForKey:@"data"] objectForKey:@"metro"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    //MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                    //[self.mapView addAnnotation:annotation];
                    [self updateDetails];
                });
            } else {
                NSLog(@"status: %ld", httpResponse.statusCode);
            }
        }
    }];
    [task resume];
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
-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    MKPolylineRenderer *routeRender = [[MKPolylineRenderer alloc] initWithPolyline: overlay];
    routeRender.strokeColor = [UIColor redColor];
    routeRender.lineWidth = 5.0;
    return routeRender;
}

#pragma mark - private methods
-(void) updateDetails {
    NSString *nameStr = [infoStation objectForKey:@"name"];
    NSString *lineStr = [infoStation objectForKey:@"line"];
    NSString *latStr = [infoStation objectForKey:@"lat"];
    CLLocationDegrees latDegrees = [latStr floatValue];
    NSString *lonStr = [infoStation objectForKey:@"lon"];
    CLLocationDegrees lonDegrees = [lonStr floatValue];
    self.labelName.text = nameStr;
    self.labelLine.text = lineStr;
    self.labelCoordinates.numberOfLines = 0;
    self.labelCoordinates.lineBreakMode = NSLineBreakByWordWrapping;
    self.labelCoordinates.text = [NSString stringWithFormat:@"(%@, %@)", latStr, lonStr];
    
    MKPointAnnotation *pointStation = [BcnDetailViewController generateAnnotation:latDegrees withLongitude:lonDegrees withTitle:nameStr withSubtitle:lineStr];
    [self.mapView addAnnotation:pointStation];
}

#pragma mark - static methods
+(MKPointAnnotation*) generateAnnotation:(CLLocationDegrees) latitude
                           withLongitude:(CLLocationDegrees) longitude
                               withTitle:(NSString *) title
                            withSubtitle:(NSString *) subTitle {
    MKPointAnnotation *pointAnnotation = [[MKPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
    pointAnnotation.title = title;
    pointAnnotation.subtitle = subTitle;
    return pointAnnotation;
}

@end
