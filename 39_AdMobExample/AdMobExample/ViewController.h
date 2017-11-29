//
//  ViewController.h
//  adds
//
//  Created by cice on 29/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

@interface ViewController : UIViewController <GADBannerViewDelegate, GADRewardBasedVideoAdDelegate>

@property(nonatomic, strong) GADBannerView *bannerView;
@property(nonatomic, strong) GADInterstitial *instertitial;

- (IBAction)actionLoadInsterstitial:(id)sender;
- (IBAction)actioLoadVideo:(id)sender;

@end
