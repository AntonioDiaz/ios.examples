
#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

#define URL_REGISTER @"http://artdinamica.com/cice/login.php"
#define KEY_LOGIN @"LOGIN"
#define KEY_PASSWORD @"PASSWORD"


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userSaved = [userDefaults objectForKey:KEY_LOGIN];
    NSString *passwordSaved = [userDefaults objectForKey:KEY_PASSWORD];
    if (userSaved != nil && ![userSaved isEqualToString:@""] && passwordSaved != nil && ![passwordSaved isEqualToString:@""]) {
        LAContext *laContext = [[LAContext alloc] init];
        NSError *laError;
        NSString *description = @"let me acces securirty system.";
        if ([laContext canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&laError]) {
            [laContext evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:description reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self login:userSaved withPassword:passwordSaved];
                });
            } else {
                //show alert with
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:laError.description delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles: nil];
                [alertView show];
                [self login:userSaved withPassword:passwordSaved];
            }
        }];
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)actionAccess:(id)sender {
    NSString *loginStr = self.textFieldUsername.text;
    NSString *passwordStr = self.textFieldPassword.text;
    [self login:loginStr withPassword:passwordStr];

    
}


- (void)login:(NSString*)userName withPassword:(NSString*)password {
    NSString *bodyRequest = [NSString stringWithFormat:@"login=%@&password=%@", userName, password];
    NSLog(@"%@", bodyRequest);
    //request config
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    //sessionConfiguration.HTTPAdditionalHeaders = dictionary.
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:URL_REGISTER];
    NSMutableURLRequest *mutableUrlRequest = [NSMutableURLRequest requestWithURL:url];
    mutableUrlRequest.HTTPMethod = @"POST";
    mutableUrlRequest.HTTPBody = [bodyRequest dataUsingEncoding:NSUTF8StringEncoding];
    NSURLSessionTask *sessionTask = [urlSession dataTaskWithRequest:mutableUrlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        BOOL loginOk = false;
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (httpResponse.statusCode == 200) {
                NSError *jsonError;
                NSDictionary *dictionaryResponse = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                NSString *alertTitle = @"Registration";
                NSString *alertDesc = [NSString stringWithFormat:@"Registration done ;-)"];
                NSString *serverErrorDesc = [dictionaryResponse objectForKey:@"error"] ;
                if (serverErrorDesc!= nil) {
                    alertTitle = @"server error";
                    alertDesc = [NSString stringWithFormat:@"Error on server: %@", serverErrorDesc];
                } else {
                    NSString *loginResult = [dictionaryResponse objectForKey:@"resultado"];
                    NSString *loginDesc = [dictionaryResponse objectForKey:@"descripcion"];
                    alertDesc = [NSString stringWithFormat:@"Resultado: %@, desc: %@",loginResult, loginDesc];
                    loginOk = [loginResult isEqualToString:@"1"];
                    if (loginOk) {
                        [self performSegueWithIdentifier:@"idShowLogin" sender:nil];
                        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                        [userDefaults setObject:userName forKey:KEY_LOGIN];
                        [userDefaults setObject:password forKey:KEY_PASSWORD];
                        [userDefaults synchronize];
                    }
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:alertTitle message:alertDesc delegate:nil cancelButtonTitle:@"Accept" otherButtonTitles: nil];
                    [alertView show];
                });
            } else {
                NSLog(@"response status code: %ld", (long)[httpResponse statusCode]);
            }
        } else {
            NSLog(@"error in task %@", error.localizedDescription);
        }
    }];
    [sessionTask resume];
    //return true;
}
@end
