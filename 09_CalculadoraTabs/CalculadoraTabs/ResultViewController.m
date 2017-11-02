#import "ResultViewController.h"

@implementation ResultViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.labelTotalCalculations.text = [NSString stringWithFormat:@"%d", calculationCount];
}

-(void) incrementCalculation {
    calculationCount++;
    self.labelTotalCalculations.text = [NSString stringWithFormat:@"%d", calculationCount];
}

@end

