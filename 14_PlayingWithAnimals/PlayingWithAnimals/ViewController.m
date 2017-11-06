//
//  ViewController.m
//  PlayingWithAnimals
//
//  Created by cice on 6/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //load values to arrays.
    arraySounds = [[NSArray alloc] initWithObjects:@"Grrr", @"Miau", @"Guau", @"Cua cua", @"moooooose",@"ori ori", @"sssss" , nil];
    
    
    
    NSString *imageBear = @"bear";
    NSString *imageCat = @"cat";
    NSString *imageDog = @"dog";
    NSString *imageGoose = @"goose";
    NSString *imageMouse = @"mouse";
    NSString *imagePig = @"pig";
    NSString *imageSnake = @"snake";
    arrayImages = [[NSArray alloc] initWithObjects:imageBear, imageCat, imageDog, imageGoose, imageMouse, imagePig, imageSnake , nil];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - <UIPickeerViewDataSource>
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component==0) {
        return [arrayImages count];
    } else {
        return [arraySounds count];
    }
}

-(UIView *) pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if(component==0) {
        NSString *fileName = [NSString stringWithFormat:@"%@.png", [arrayImages objectAtIndex:row]];
        UIImage *image = [UIImage imageNamed:fileName];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        return imageView;
    } else {
        UILabel *labelSound = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 32)];
        labelSound.text = [arraySounds objectAtIndex:row];
        return labelSound;
    }
}

-(CGFloat) pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    if(component==0) {
        return 70;
    } else {
        return 10;
    }
}

#pragma mark - <UIPickerDelegate>
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString *lastMovement;
    if(component==0) {
        NSString *strImage = [arrayImages objectAtIndex:row];
        lastMovement = [NSString stringWithFormat:@"Last movement image: %@", strImage];
    } else {
        NSString *strSound = [arraySounds objectAtIndex:row];
        lastMovement = [NSString stringWithFormat:@"Last movement image: %@", strSound];
    }
    self.labelLastMovement.text = lastMovement;
    int positionImage = [pickerView selectedRowInComponent:0];
    int positionSound = [pickerView selectedRowInComponent:1];
    NSString *strSoundSelected = [arraySounds objectAtIndex:positionSound];
    NSString *stsImageSelected = [arrayImages objectAtIndex:positionImage];
    NSString *result;
    if (positionImage == positionSound) {
        result = @"OK";
    } else {
        result = @"ERROR";
    }
    self.labelResult.text = [NSString stringWithFormat:@"%@ sounds like %@?? %@", stsImageSelected, strSoundSelected, result];
}



@end
