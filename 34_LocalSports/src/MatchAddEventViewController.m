#import "MatchAddEventViewController.h"
#import "SportCourtEntity+CoreDataProperties.h"
#import "Utils.h"

@implementation MatchAddEventViewController

@synthesize matchEntity;

- (void)viewDidLoad {
    [super viewDidLoad];
    eventStore = [[EKEventStore alloc]init];
    self.navigationItem.title = @"Add match to calendar";
    self.textFieldTitle.text = [NSString stringWithFormat:@"Week %d: %@ vs %@", matchEntity.week, matchEntity.teamLocal, matchEntity.teamVisitor];
    self.textFieldDate.text = [Utils formatDateDoubleToStr:matchEntity.date];
    self.textFieldPlace.text = matchEntity.court.centerAddress;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)actionAddEvent:(id)sender {
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            //alertView must run on main thread.
            [Utils showAlert:@"need access to calendar."];
        } else {
            EKEvent *event = [EKEvent eventWithEventStore:eventStore];
            event.calendar = eventStore.defaultCalendarForNewEvents;
            event.title = self.textFieldTitle.text;
            NSDate *initDate = [Utils formatDateDoubleToDate:matchEntity.date];
            event.startDate = initDate;
            event.endDate = [initDate dateByAddingTimeInterval: SECONDS_IN_TWO_HOURS];
            //saving event.
            NSError *error = nil;
            [eventStore saveEvent:event span:EKSpanThisEvent error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    [Utils showAlert:@"Error when adding calendar"];
                } else {
                    [Utils showAlert:@"Match added to calendar"];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            });
        }
    }];
}
@end
