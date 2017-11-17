//
//  ViewController.m
//  MapsAndPaths
//
//  Created by cice on 17/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"
#define EMPTY_STR @""
#define UNDERSCORE_STR @"_"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //start location manager.
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestWhenInUseAuthorization];
    locationManager.delegate = self;
    
    //config map
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = true;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)searchDestination:(id)sender {
    NSString *userInput = ((UITextField*) sender).text;
    NSLog(@"%@", self.textFieldUserAddress.text);
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:userInput completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error @%", error);
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

- (IBAction)calculatePath:(id)sender {
    MKDirectionsRequest *directionRequest = [[MKDirectionsRequest alloc] init];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:selectedLocation];
    [directionRequest setDestination:[[MKMapItem alloc] initWithPlacemark:placemark]];
    [directionRequest setSource:[MKMapItem mapItemForCurrentLocation]];
    MKDirections *directions = [[MKDirections alloc]initWithRequest:directionRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            MKRoute *route = [response.routes lastObject];
            [self.mapView addOverlay:route.polyline];
            
            self.labelAddress.text = [selectedLocation.addressDictionary objectForKey:@"Street"];
            self.labelDistance.text = [NSString stringWithFormat:@"%.2f Kms", route.distance/1000];
            self.labelTransport.text = [NSString stringWithFormat:@"%i", route.transportType];
            
            NSString *steps = EMPTY_STR;
            for (MKRouteStep *step in route.steps) {
                steps = [steps stringByAppendingString:step.instructions];
                steps = [steps stringByAppendingString:@"\n\n"];
            }
            self.textViewRoute.text = steps;
        }
    }];
    
}

- (IBAction)cleanPath:(id)sender {
    self.textFieldUserAddress.text = EMPTY_STR;
    self.labelAddress.text = UNDERSCORE_STR;
    self.labelDistance.text = UNDERSCORE_STR;
    self.labelTransport.text = UNDERSCORE_STR;
}


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
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake(ubication.location.coordinate.latitude, ubication.location.coordinate.longitude);
    point.title = [ubication.addressDictionary objectForKey:@"Street"];
    point.subtitle = [ubication.addressDictionary objectForKey:@"Street"];
    [self.mapView addAnnotation:point];
}
@end
