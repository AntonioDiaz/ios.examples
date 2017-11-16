//
//  ViewController.h
//  MapsExamples
//
//  Created by cice on 16/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
    CLLocationManager *locationManager;
}


@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

