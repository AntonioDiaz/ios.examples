#import "MatchSendIssueViewController.h"
#import "SportCourtEntity+CoreDataProperties.h"
#import "CompetitionEntity+CoreDataProperties.h"
#import <QuartzCore/QuartzCore.h>
#import "Utils.h"

@implementation MatchSendIssueViewController

@synthesize matchEntity;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"ISSUE_TITLE", nil);
    [[self.textViewDescription layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.textViewDescription layer] setBorderWidth:2];
    [[self.textViewDescription layer] setCornerRadius:5];
    self.textFieldTitle.text = [NSString stringWithFormat:NSLocalizedString(@"ISSUE_TEXT_TITLE", nil), matchEntity.week, matchEntity.teamLocal, matchEntity.teamVisitor];
    self.textFieldDate.text = [Utils formatDateDoubleToStr:matchEntity.date];
    self.textFieldPlace.text = matchEntity.court.centerName;
    self.textViewDescription.text = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)actionSendIssue:(id)sender {
    //check if issue description is filled.
    if (self.textViewDescription.text.length==0) {
        [Utils showAlert:NSLocalizedString(@"ISSUE_DESCRIPTION_REQUIRED", nil)];
    } else {
        NSString *clientId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString *competitionId = [[NSNumber numberWithDouble:matchEntity.competition.idCompetitionServer] stringValue];
        NSString *matchId = [[NSNumber numberWithDouble:matchEntity.idServer] stringValue];
        NSString *description = self.textViewDescription.text;
        NSDictionary *dictionaryPost = [[NSDictionary alloc]
                                        initWithObjectsAndKeys: clientId, @"clientId", competitionId, @"competitionId", matchId, @"matchId", description, @"description", nil];
        NSString *bodyRequest = [Utils dictionaryToString:dictionaryPost];
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.HTTPAdditionalHeaders = [[NSDictionary alloc] initWithObjectsAndKeys:@"application/json", @"Content-Type", nil];
        NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        NSURL *url = [NSURL URLWithString:URL_SEND_ISSUE];
        NSMutableURLRequest *mutableUrlRequest = [NSMutableURLRequest requestWithURL:url];
        mutableUrlRequest.HTTPMethod = @"POST";
        mutableUrlRequest.HTTPBody = [bodyRequest dataUsingEncoding:NSUTF8StringEncoding];
        NSURLSessionTask *sessionTask = [urlSession dataTaskWithRequest:mutableUrlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                if (httpResponse.statusCode == 200) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [Utils showAlert:NSLocalizedString(@"ISSUE_REGISTERED", nil)];
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSString *errorMsg = [NSString stringWithFormat: NSLocalizedString(@"ISSUE_SEND_HTTP_ERROR", nil), (int) httpResponse.statusCode];
                        [Utils showAlert: errorMsg];
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *errorMsg = [NSString stringWithFormat: NSLocalizedString(@"ISSUE_SEND_ERROR", nil), error.localizedDescription];
                    [Utils showAlert: errorMsg];
                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
        }];
        [sessionTask resume];
    }
}
@end
