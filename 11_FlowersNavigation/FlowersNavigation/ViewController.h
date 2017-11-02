//
//  ViewController.h
//  FlowersNavigation
//
//  Created by cice on 2/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    NSString *urlFlower;
}
@property (strong, nonatomic) IBOutlet NSString *urlFlower;
@property (weak, nonatomic) IBOutlet UIWebView *webViewFlower;

@end

