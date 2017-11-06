//
//  ViewController.h
//  PlayingWithAnimals
//
//  Created by cice on 6/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource> {
    NSArray *arrayImages;
    NSArray *arraySounds;
}

@property (weak, nonatomic) IBOutlet UIPickerView *pickerAnimals;
@property (weak, nonatomic) IBOutlet UILabel *labelLastMovement;
@property (weak, nonatomic) IBOutlet UILabel *labelResult;

@end

