#import "MapViewController.h"
#import "AppDelegate.h"
#import "LocationEntity+CoreDataProperties.h"
#import "WrapPointAnnotation.h"

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = true;
    
    //config locationmanager
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    locationManager.delegate = self;
    locationManager.distanceFilter = 30;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    
    
    //config map region.
    CLLocation *location = [[CLLocation alloc]
                            initWithLatitude:locationManager.location.coordinate.latitude
                            longitude:locationManager.location.coordinate.longitude];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(location.coordinate, 1000, 1000);
    region.center.latitude = locationManager.location.coordinate.latitude;
    region.center.longitude = locationManager.location.coordinate.longitude;
    region.span = MKCoordinateSpanMake(0.04, 0.04);
    [self.mapView setRegion:region];

    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description =
    [NSEntityDescription entityForName:@"LocationEntity" inManagedObjectContext:context];
    [request setEntity:description];
    NSError *error;
    NSArray *queryResults = [context executeFetchRequest:request error:&error];

    for (LocationEntity *locationEntiy in queryResults) {
        WrapPointAnnotation *pointAnnotation = [[WrapPointAnnotation alloc] init];
        pointAnnotation.coordinate = CLLocationCoordinate2DMake([locationEntiy.latitude floatValue], [locationEntiy.longitude floatValue]);
        pointAnnotation.title = locationEntiy.title;
        
        
        pointAnnotation.image = [UIImage imageWithContentsOfFile:locationEntiy.image];
        [self.mapView addAnnotation:pointAnnotation];
    }
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
            UIImage *image = ((WrapPointAnnotation *)annotation).image;
            image = [MapViewController imageWithImage:image scatedToSize:CGSizeMake(20, 20)];
            annotationView.image = image;
            
            //annotationView.leftCalloutAccessoryView = imageView;
            
        } else {
            annotationView.annotation = annotation;
        }
        return annotationView;
    }
    return nil;
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
