#import "RegisterUserViewController.h"
#define URL_POST @"http://artdinamica.com/cice/usuario.php"

@implementation RegisterUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - actions
- (IBAction)actionAcceptRegister:(id)sender {
    NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString *userName = self.textFieldUserName.text;
    NSString *bodyRequest = [NSString stringWithFormat:@"usuario=%@UUID=%@", userName, deviceId];
    NSLog(@"%@", bodyRequest);
    //request config
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //sessionConfiguration.HTTPAdditionalHeaders = dictionary.
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:URL_POST];
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
}
@end
