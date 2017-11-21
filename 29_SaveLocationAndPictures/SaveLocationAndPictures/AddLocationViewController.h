//
//  AddLocationViewController.h
//  SaveLocationAndPictures
//
//  Created by cice on 20/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface AddLocationViewController : ViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UITextField *textViewTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewLocation;
@property (weak, nonatomic) IBOutlet UIButton *buttonCamera;
- (IBAction)actionLibrary:(id)sender;
- (IBAction)actionCamera:(id)sender;
- (IBAction)actionSaveLocation:(id)sender;


@end
