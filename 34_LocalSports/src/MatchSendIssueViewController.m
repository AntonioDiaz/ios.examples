#import "MatchSendIssueViewController.h"
#import "SportCourtEntity+CoreDataProperties.h"
#import "CompetitionEntity+CoreDataProperties.h"
#import <QuartzCore/QuartzCore.h>
#import "Utils.h"

@implementation MatchSendIssueViewController

@synthesize matchEntity;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"Notify issue";
    [[self.textViewDescription layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.textViewDescription layer] setBorderWidth:2];
    [[self.textViewDescription layer] setCornerRadius:5];

    self.textFieldTitle.text = [NSString stringWithFormat:@"Week %d: %@ vs %@", matchEntity.week, matchEntity.teamLocal, matchEntity.teamVisitor];
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
        [Utils showAlert:@"Issue description is required"];
    } else {
        NSString *clientId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
        NSString *competitionId = [[NSNumber numberWithDouble:matchEntity.competition.idCompetitionServer] stringValue];
        NSString *matchId = [[NSNumber numberWithDouble:matchEntity.idServer] stringValue];
        NSString *description = self.textViewDescription.text;
        
        NSString *bodyRequest = [NSString stringWithFormat:@"clientId=%@&competitionId=%@&matchId&matchId=%@&description=%@", clientId, competitionId, matchId, description];
        NSLog(@"%@", bodyRequest);
        //request config
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        //sessionConfiguration.HTTPAdditionalHeaders = dictionary.
        NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];
        NSURL *url = [NSURL URLWithString:URL_SEND_ISSUE];
        NSMutableURLRequest *mutableUrlRequest = [NSMutableURLRequest requestWithURL:url];
        mutableUrlRequest.HTTPMethod = @"POST";
        mutableUrlRequest.HTTPBody = [bodyRequest dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURLSessionTask *sessionTask = [urlSession dataTaskWithRequest:mutableUrlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (!error) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                if (httpResponse.statusCode == 200) {
                    NSError *jsonError;
                    NSDictionary *dictionaryResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                    NSLog(@"response %@", dictionaryResponse);
                    NSString *alertTitle = @"Registration";
                    NSString *alertDesc = [NSString stringWithFormat:@"Registration done ;-)"];
                    NSString *serverErrorDesc = [dictionaryResponse objectForKey:@"error"] ;
                    if (serverErrorDesc!= nil) {
                        alertTitle = @"server error";
                        alertDesc = [NSString stringWithFormat:@"Error on server: %@", serverErrorDesc];
                    }
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:alertDesc delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles: nil];
                        [alertView show];
                    });
                } else {
                    NSLog(@"http error %@", httpResponse.statusCode);
                }
            } else {
                NSLog(@"error in task %@", error.localizedDescription);
            }
        }];
        [sessionTask resume];
        
        
        /*
         "clientId": "xxxxxx",
         "competitionId": "6416141048086528",
         "matchId": "6273556186923008",
         "description": "esta mal algo ahi..."
         */
        
        
        
    }
    
}
@end
