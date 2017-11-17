//
//  ViewController.h
//  MapsAndPaths
//
//  Created by cice on 17/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>{
     CLLocationManager *locationManager;
    CLPlacemark * selectedLocation;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextField *textFieldUserAddress;

@property (weak, nonatomic) IBOutlet UILabel *labelAddress;
@property (weak, nonatomic) IBOutlet UILabel *labelDistance;
@property (weak, nonatomic) IBOutlet UILabel *labelTransport;
@property (weak, nonatomic) IBOutlet UITextView *textViewRoute;
- (IBAction)searchDestination:(id)sender;
- (IBAction)calculatePath:(id)sender;
- (IBAction)cleanPath:(id)sender;

@end
