#import "ViewController.h"
#import "Country+CoreDataProperties.h"

@interface PopOverNewCityViewController : ViewController <UIAlertViewDelegate>

@property(nonatomic, retain) Country *country;
@property (weak, nonatomic) IBOutlet UITextField *textViewName;

- (IBAction)actionCancel:(id)sender;
- (IBAction)actionAccept:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *cityName;
@property (weak, nonatomic) IBOutlet UITextField *cityDescription;
@property (weak, nonatomic) IBOutlet UITextField *cityImage;
@property (weak, nonatomic) IBOutlet UITextField *monument1Name;
@property (weak, nonatomic) IBOutlet UITextField *monument1Url;
@property (weak, nonatomic) IBOutlet UITextField *monument1Image;
@property (weak, nonatomic) IBOutlet UITextField *monument1Longitude;
@property (weak, nonatomic) IBOutlet UITextField *monument1Latitude;

@property (weak, nonatomic) IBOutlet UITextField *monument2Name;
@property (weak, nonatomic) IBOutlet UITextField *monument2Url;
@property (weak, nonatomic) IBOutlet UITextField *monument2Image;
@property (weak, nonatomic) IBOutlet UITextField *monument2Longitude;
@property (weak, nonatomic) IBOutlet UITextField *monument2Latitude;

@end
