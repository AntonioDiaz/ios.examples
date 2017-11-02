//
//  main.m
//  SintaxisAntonio
//
//  Created by cice on 24/10/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <Foundation/Foundation.h>

#define NUM_PATAS 4

@interface SampleClass:NSObject
    -(void)samplethod:(int)num;
@end

@implementation SampleClass
    -(void)samplethod:(int)myPata{
        NSLog(@"Hello IOS! %d \n", myPata);
    }
@end

int main(int argc, char * argv[]) {
     SampleClass *sampleClass= [[SampleClass alloc] init];
     int i=0;
     while (true) {
         [sampleClass samplethod:i];
         i++;
         if (i>=NUM_PATAS) {
             break;
         }
     }
     return 0;
}
