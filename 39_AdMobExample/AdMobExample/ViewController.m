#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadBanner];
    [self configurarInterstitial];
    [self configVideo];
    
    //creamos restricciones del autolayout para poner el baneer abajo y centrado.
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void) configVideo {
    [[GADRewardBasedVideoAd sharedInstance] loadRequest:[GADRequest request] withAdUnitID:@"ca-app-pub-3940256099942544/1712485313"];
    [GADRewardBasedVideoAd sharedInstance].delegate = self;
}

-(void)loadBanner{
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    //self.bannerView.frame = CGRectMake(200, 520, , 100.0);
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    
    
    
    //cuando se clica en el banner, quien se encarga de navegar.
    self.bannerView.rootViewController = self;
    
    //para controlar el flujo del banner, podemos ser los delegados.
    self.bannerView.delegate = self;
    
    // lo enlazamos con la vista del controlador.
    [self.view addSubview:self.bannerView];
    
    //Cargamos el anuncio
    [self.bannerView loadRequest:[GADRequest request]];
    
    NSLayoutConstraint *abajo = [NSLayoutConstraint constraintWithItem:self.bannerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    NSLayoutConstraint *centrado = [NSLayoutConstraint constraintWithItem:self.bannerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    //[self.bannerView addConstraint:abajo];
    //[self.bannerView addConstraint:centrado];
}


-(void)configurarInterstitial{
    self.instertitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3940256099942544/4411468910"];
    [self.instertitial loadRequest:[GADRequest request]];
}


#pragma mark -
-(void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage =
    [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",
     reward.type,
     [reward.amount doubleValue]];
    NSLog(rewardMessage);
}

#pragma mark -
//cuando se carga el anuncio
-(void)adViewDidReceiveAd:(GADBannerView *)bannerView {
    bannerView.alpha = 0;
    [UIView animateWithDuration:3.0 animations:^{
        bannerView.alpha = 1;
    }];
}

//si falla la carga.
-(void)adView:(GADBannerView*) bannerView didFailToReceiveAdWithError:(nonnull GADRequestError *)error {
    NSLog(@"didFailToReceiveAdWithError");
    NSLog(@"%@", error.description);
}


//si el usuario clica sobre el anuncio.
-(void) adViewWillPresentScreen:(GADBannerView *)bannerView {
    NSLog(@"adViewWillPresentScreen");
}




- (IBAction)actionLoadInsterstitial:(id)sender {
    if (self.instertitial.isReady) {
        [self.instertitial presentFromRootViewController:self];
    } else {
        NSLog(@"error on load instertitial");
    }
    
}

- (IBAction)actioLoadVideo:(id)sender {
    if ([[GADRewardBasedVideoAd sharedInstance] isReady]) {
        [[GADRewardBasedVideoAd sharedInstance] presentFromRootViewController:self];
    } else {
        NSLog(@"error on load video.");
    }
    
}
@end

