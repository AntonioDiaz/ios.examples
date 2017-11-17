//
//  ViewController.m
//  GeoFences
//
//  Created by cice on 17/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //config locationManager.
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    [locationManager requestAlwaysAuthorization];
    [locationManager startUpdatingLocation];
    
    //config areas to be alert
    CLLocationCoordinate2D coordinates2d = CLLocationCoordinate2DMake(40.3186257,-3.7744148);
    CLCircularRegion *region = [[CLCircularRegion alloc] initCircularRegionWithCenter:coordinates2d radius:100 identifier:@"antoine_house"];
    //join region and location manager.
    [locationManager startMonitoringForRegion:region];
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.allowsBackgroundLocationUpdates = true;
    
    //config notification
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    [notificationCenter requestAuthorizationWithOptions:(UNAuthorizationOptionBadge|UNAuthorizationOptionAlert | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (!error) {
            NSLog(@"notification allowed");
        }
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - CLLocationManagerDelegate
-(void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"ENTRA EN LA REGION");
    NSString *title = @"welcome";
    NSString *description = @"You are inside....";
    [self sendNotification:title withDescription:description];
    
}

-(void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    NSLog(@"EXIT EN LA REGION");
    NSString *title = @"see you :)";
    NSString *description = @"You are outside....";
    [self sendNotification:title withDescription:description];
    
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    NSLog(@"change status");
    [locationManager startUpdatingLocation];
}


#pragma mark - private methods
-(void)sendNotification:(NSString *) notificationTitle withDescription:(NSString *) notificationDescription {
    //config noticifacion content
    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
    notificationContent.title = notificationTitle;
    notificationContent.subtitle = notificationDescription;
    notificationContent.sound = [UNNotificationSound defaultSound];
    //config badge, red circle inside app icon.
    NSInteger actualBadge =  [[UIApplication sharedApplication] applicationIconBadgeNumber];
    notificationContent.badge =  [NSNumber numberWithInt:actualBadge + 1] ;
    //when send notification
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2.0 repeats:false];
    
    UNNotificationRequest *notificationRequest = [UNNotificationRequest requestWithIdentifier:@"Notification" content:notificationContent trigger:trigger];
    //send notification to notitication center.
    UNUserNotificationCenter *notificationCenter = [UNUserNotificationCenter currentNotificationCenter];
    [notificationCenter addNotificationRequest:notificationRequest withCompletionHandler:^(NSError * _Nullable error) {
        if (!error){
            NSLog(@"ok");
        } else {
            NSLog(@"error");
        }
     
    }];
    
}

@end
