//
//  ViewController.h
//  adds
//
//  Created by cice on 29/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>
@import GoogleMobileAds;

@interface ViewController : UIViewController <GADBannerViewDelegate>

@property(nonatomic, strong) GADBannerView *bannerView;

@end

