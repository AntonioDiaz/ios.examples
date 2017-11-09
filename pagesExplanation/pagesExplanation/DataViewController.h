//
//  DataViewController.h
//  pagesExplanation
//
//  Created by cice on 9/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) NSDictionary *dataObject;
@property (weak, nonatomic) IBOutlet UILabel *labelCityName;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCity;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic) NSInteger pagesNum;
@property (nonatomic) NSInteger currentPage;
@end

