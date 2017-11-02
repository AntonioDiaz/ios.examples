//
//  ViewController.m
//  AlumnosVentana
//
//  Created by cice on 27/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "ViewController.h"
#import "Student.h"

@interface ViewController ()

@end

@implementation ViewController

-(IBAction)addStudent:(id)sender {
    NSString *nombre = self.tfNombre.text;
    int edad = [self.tfEdad.text integerValue];
    student = [[Student alloc] initWithName:nombre andEdad:edad];
    self.showState;
}
-(IBAction)addResult:(id)sender {
    NSString *notaStr = self.tfMark.text;
    if(self.switchPractic.isOn) {
        [student guadarProyecto:[notaStr longLongValue]];
    } else {
        [student guardarNuevaNota:[notaStr longLongValue]];
    }
    self.showState;
}
-(IBAction)showResults:(id)sender {
    self.showState;
}

-(void) showState {
    NSString *result = @"no inicializado";
    if (student!=nil) {
        result = [student imprimExamenes];
    }
    self.results.text = result;
    BOOL apto = [student calculaNota];
    UIImage *myImage;
    if (apto) {
        myImage = [UIImage imageNamed:@"ok.png"];
    } else {
        myImage = [UIImage imageNamed:@"ko.jpg"];
    }
    self.imageResult.image = myImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
