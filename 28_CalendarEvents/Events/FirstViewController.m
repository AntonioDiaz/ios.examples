#import "FirstViewController.h"

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    eventStore = [[EKEventStore alloc]init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark - actions
- (IBAction)actionSaveEvent:(id)sender {
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            //alertView must run on main thread.
            [self showAlert:@"Event" withSubtitle:@"access needed"];
        } else {
            EKEvent *event = [EKEvent eventWithEventStore:eventStore];
            event.calendar = eventStore.defaultCalendarForNewEvents;
            event.title = self.textFieldTitle.text;
            NSDate *initDate = self.datePickerEvent.date;
            event.startDate = initDate;
            event.endDate = [initDate dateByAddingTimeInterval:[self.textFieldLength.text intValue] * 60 * 60];
            //saving event.
            NSError *error = nil;
            [eventStore saveEvent:event span:EKSpanThisEvent error:&error];
            if (error) {
                [self showAlert:@"Event" withSubtitle:@"Error on adding"];
            } else {
                [self showAlert:@"Event" withSubtitle:@"calendar event added"];
            }
        }
    }];
}

- (IBAction)actionHideKeyboard:(id)sender {
    NSLog(@"hide keyboard");
    [self.view endEditing:YES];
    
}

#pragma mark - private methods
-(void) showAlert:(NSString *)title withSubtitle:(NSString *)subtitle {
    dispatch_sync(dispatch_get_main_queue(), ^{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:subtitle delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
        [alertView show];
    });
}
@end
