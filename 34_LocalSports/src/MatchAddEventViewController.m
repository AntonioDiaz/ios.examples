#import "MatchAddEventViewController.h"
#import "SportCourtEntity+CoreDataProperties.h"
#import "Utils.h"

@implementation MatchAddEventViewController

@synthesize matchEntity;

- (void)viewDidLoad {
    //TODO: check if event is allready added to the calendar.
    [super viewDidLoad];
    eventStore = [[EKEventStore alloc]init];
    self.navigationItem.title = NSLocalizedString(@"CALENDAR_EVENT_TITLE", nil);
    self.labelTitle.text = [NSString stringWithFormat:NSLocalizedString(@"CALENDAR_EVENT_TEXT", nil), matchEntity.week, matchEntity.teamLocal, matchEntity.teamVisitor];
    self.labelDate.text = [Utils formatDateDoubleToStr:matchEntity.date];
    self.labelPlace.text = matchEntity.court.centerAddress;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)actionAddEvent:(id)sender {
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (!granted) {
            //alertView must run on main thread.
            [Utils showAlert:NSLocalizedString(@"CALENDAR_ACCESS", nil)];
        } else {
            EKEvent *event = [EKEvent eventWithEventStore:eventStore];
            event.title = [NSString stringWithFormat:NSLocalizedString(@"CALENDAR_EVENT_TEXT", nil), matchEntity.week, matchEntity.teamLocal, matchEntity.teamVisitor];
            event.calendar = eventStore.defaultCalendarForNewEvents;
            NSDate *initDate = [Utils formatDateDoubleToDate:matchEntity.date];
            event.location = matchEntity.court.centerAddress;
            event.startDate = initDate;
            event.endDate = [initDate dateByAddingTimeInterval: SECONDS_IN_TWO_HOURS];
            //saving event.
            NSError *error = nil;
            [eventStore saveEvent:event span:EKSpanThisEvent error:&error];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    [Utils showAlert:NSLocalizedString(@"CALENDAR_ERROR", nil)];
                } else {
                    [Utils showAlert:NSLocalizedString(@"CALENDAR_SUCCESS", nil)];
                    [self.navigationController popViewControllerAnimated:YES];
                }
            });
        }
    }];
}
@end
