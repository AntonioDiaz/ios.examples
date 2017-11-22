#import "BcnViewController.h"
#define URL_API_BCN @"http://barcelonaapi.marcpous.com/metro/station/id/%@.json"
#define APP_TITLE @"Barcelona Transport"

@implementation BcnViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    locationManager.delegate = self; //CLLocationManagerDelegate
    [locationManager startUpdatingLocation];
    //config map
    self.mapView.delegate = self; //MKMapViewDelegate

    
    // 1. config NSURLSession
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    //config.HTTPAdditionalHeaders = [NSDictionary alloc] initWithObjectsAndKeys:@"fkelsffeials", @"API_KEY", nil;
    // 2. init session
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config];
    NSString *urlStr = [NSString stringWithFormat:URL_API_BCN, self.idMetroStation];
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 3. create task
    NSURLSessionTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //check status code.
        if (error) {
            NSLog(@"Error on task: %@", error.description);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (httpResponse.statusCode == 200) {
                NSError *jsonError = nil;
                NSDictionary *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                infoStation = [[jsonResults objectForKey:@"data"] objectForKey:@"metro"];
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.navigationItem.title = [infoStation objectForKey:@"name"];
                 
                    float latitude = [[infoStation objectForKey:@"lat"] floatValue];
                    float longitude = [[infoStation objectForKey:@"log"] floatValue];
                    
                    //CLLocationCoordinate2D *coordinate = CLLocationCoordinate2DMake (latitude, longitude);
                    
                    //MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 1000, 1000);

                    //self.mapView.region = region;
                    
                    CLLocation *location = [[CLLocation alloc]
                                            initWithLatitude:locationManager.location.coordinate.latitude
                                            longitude:locationManager.location.coordinate.longitude];
                    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000);
                    
                    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                    
                    [self.mapView addAnnotation:annotation];
                    
                    
                });
            } else {
                NSLog(@"status: %ld", httpResponse.statusCode);
            }
        }
    }];
    // 4. throw task
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



@end
