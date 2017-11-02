#import <UIKit/UIKit.h>

@interface ResultViewController : UIViewController
{
    int calculationCount;
}
@property (weak, nonatomic) IBOutlet UILabel *labelTotalCalculations;

-(void) incrementCalculation;
@end


