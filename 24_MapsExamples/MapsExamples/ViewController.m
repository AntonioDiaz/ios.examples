//
//  ViewController.m
//  MapsExamples
//
//  Created by cice on 16/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    locationManager = [[CLLocationManager alloc] init];
    [locationManager requestAlwaysAuthorization];
    
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
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.showsScale = true;
    self.mapView.showsCompass = true;
    self.mapView.zoomEnabled = true;

    //user location
    self.mapView.showsUserLocation = true;
    self.mapView.userLocation.title = @"Here I am";
    self.mapView.userLocation.subtitle = @"This is Antoine";
    [self addTumbTack];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(nonnull NSArray<CLLocation *> *)locations {
    CLLocation *location = [locations objectAtIndex:0];
    [self.mapView setCenterCoordinate:location.coordinate animated:true];
}

#pragma mark - private methods
-(void) addTumbTack {
    MKPointAnnotation *pointLopeDeVega = [[MKPointAnnotation alloc] init];
    pointLopeDeVega.coordinate = CLLocationCoordinate2DMake(40.3204539,-3.7749351);
    pointLopeDeVega.title = @"Lope de Vega";
    pointLopeDeVega.subtitle = @"Public School";
    [self.mapView addAnnotation:pointLopeDeVega];
    
    
    MKPointAnnotation *pointSeveroOchoa = [[MKPointAnnotation alloc] init];
    pointSeveroOchoa.coordinate = CLLocationCoordinate2DMake(40.3193087,-3.7725426);
    pointSeveroOchoa.title = @"Severo Ochoa";
    pointSeveroOchoa.subtitle = @"Public Hosital";
    [self.mapView addAnnotation:pointSeveroOchoa];
}

#pragma mark - MKMapViewDelegate
-(MKAnnotationView*) mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    //to change the locatio blue point.
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        
    //to change the locatio blue point.
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

-(void)clickPin:(id)sender {
    NSLog(@"click on monument");
}

+ (UIImage *) imageWithImage:(UIImage *) image scatedToSize:(CGSize) newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
