#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelQuestion.text = NSLocalizedString(@"¿Cómo estás?", nil);
    
    [self.buttonLike setTitle:NSLocalizedString(@"Estoy bien!", nil) forState:UIControlStateNormal];
    
    
    NSNumberFormatter *numberFormater = [[NSNumberFormatter alloc] init];
    [numberFormater setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *numSoldApps = [numberFormater stringFromNumber:[NSNumber numberWithInteger:10000]];
    
    
    self.labelAnswer.text = [NSString stringWithFormat:NSLocalizedString(@"Ayer vendi %@ apps in AppStore", nil), numSoldApps];
    
    //translate images
    self.imagevViewLike.image = [UIImage imageNamed:NSLocalizedString(@"like.png", nil)];

    //get device language
    NSLog(@"you device is on %@", [[NSLocale preferredLanguages] firstObject]);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
