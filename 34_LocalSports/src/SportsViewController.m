#import "AppDelegate.h"
#import "SportsViewController.h"
#import "CompetitionsTableViewController.h"
#import "CompetitionEntity+CoreDataProperties.h"
#import "UtilsDataBase.h"

@implementation SportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    managedObjectContext = app.persistentContainer.viewContext;
    self.navigationItem.hidesBackButton = YES;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *townSelected = [userDefaults objectForKey:PREF_TOWN_NAME];
    NSString *idTownSelected = [userDefaults objectForKey:PREF_TOWN_ID];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ - %@", APP_NAME, townSelected];
    
    UIImage *image = [[UIImage imageNamed:@"menu"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(showSideMenu:)];
    self.navigationItem.leftBarButtonItem = button;
    
    [self initSportButton:self.buttonFootball];
    [self initSportButton:self.buttonBasketball];
    [self initSportButton:self.buttonHandball];
    [self initSportButton:self.buttonVolleyball];
    [self initSportButton:self.buttonHockey];
    [self initSportButton:self.buttonFavorites];
    if (![Utils noTengoInterne]) {
        [self loadCompetitions:idTownSelected];
    }
    [self loadBanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - private methods
-(void)loadBanner{
    self.bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    //self.bannerView.frame = CGRectMake(0, 0, self.bannerView.frame.size.width , self.bannerView.frame.size.height);
    self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    //cuando se clica en el banner, quien se encarga de navegar.
    self.bannerView.rootViewController = self;
    
    //para controlar el flujo del banner, podemos ser los delegados.
    self.bannerView.delegate = self;
    
    // lo enlazamos con la vista del controlador.
    [self.viewHostingBanner addSubview:self.bannerView];
    
    //Cargamos el anuncio
    [self.bannerView loadRequest:[GADRequest request]];
    [self.view addConstraints:@[
                                [NSLayoutConstraint constraintWithItem:self.bannerView
                                                             attribute:NSLayoutAttributeBottom
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.bottomLayoutGuide
                                                             attribute:NSLayoutAttributeTop
                                                            multiplier:1
                                                              constant:0],
                                [NSLayoutConstraint constraintWithItem:self.bannerView
                                                             attribute:NSLayoutAttributeCenterX
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self.view
                                                             attribute:NSLayoutAttributeCenterX
                                                            multiplier:1
                                                              constant:0]
                                ]];
}

- (void)addBannerViewToView:(UIView *)bannerView {
    bannerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:bannerView];
    if (@available(ios 11.0, *)) {
        // In iOS 11, we need to constrain the view to the safe area.
        [self positionBannerViewFullWidthAtBottomOfSafeArea:bannerView];
    } else {
        // In lower iOS versions, safe area is not available so we use
        // bottom layout guide and view edges.
        [self positionBannerViewFullWidthAtBottomOfView:bannerView];
    }
}

#pragma mark - view positioning

- (void)positionBannerViewFullWidthAtBottomOfSafeArea:(UIView *_Nonnull)bannerView NS_AVAILABLE_IOS(11.0) {
    // Position the banner. Stick it to the bottom of the Safe Area.
    // Make it constrained to the edges of the safe area.
    UILayoutGuide *guide = self.view.safeAreaLayoutGuide;
    
    [NSLayoutConstraint activateConstraints:@[
                                              [guide.leftAnchor constraintEqualToAnchor:bannerView.leftAnchor],
                                              [guide.rightAnchor constraintEqualToAnchor:bannerView.rightAnchor],
                                              [guide.bottomAnchor constraintEqualToAnchor:bannerView.bottomAnchor]
                                              ]];
}

- (void)positionBannerViewFullWidthAtBottomOfView:(UIView *_Nonnull)bannerView {
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bannerView
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bannerView
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:bannerView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.bottomLayoutGuide
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
}

-(void) showSideMenu:(id)sender {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:nil forKey:PREF_TOWN_NAME];
    [userDefaults setValue:nil forKey:PREF_TOWN_ID];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void) enableSportButtons {
    self.buttonFootball.enabled = true;
    self.buttonBasketball.enabled = true;
    self.buttonVolleyball.enabled = true;
    self.buttonHandball.enabled = true;
    self.buttonHockey.enabled = true;
    self.buttonFavorites.enabled = true;
}

-(void) initSportButton:(UIButton*)button {
    [button setContentMode:UIViewContentModeCenter];
    [button.imageView setContentMode:UIViewContentModeScaleAspectFit];
    button.enabled = false;
}

-(void) loadCompetitions:(NSString *) idTown {
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *urlSession = [NSURLSession sessionWithConfiguration:config];
    NSString *strUrlCompetitions = [NSString stringWithFormat:URL_COMPETITIONS, idTown];
    NSURL *url = [NSURL URLWithString:strUrlCompetitions];
    NSURLSessionTask *task = [urlSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"Error on task: %@", error.description);
        } else {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            if (httpResponse.statusCode == 200) {
                NSError *jsonError = nil;
                NSArray *jsonResults = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                NSLog(@"competition size %lu", (unsigned long)jsonResults.count);
                dispatch_async(dispatch_get_main_queue(), ^{
                    //first remove all competitions.
                    [UtilsDataBase deleteAllEntities:COMPETITION_ENTITY];
                   for (NSDictionary *competition in jsonResults) {
                       [UtilsDataBase insertCompetition:competition];
                    }
                    [self enableSportButtons];
                });
            } else {
                NSLog(@"status: %d", (int)httpResponse.statusCode);
            }
        }
    }];
    [task resume];
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"BACK", nil) style:UIBarButtonItemStylePlain target:nil action:nil];
    CompetitionsTableViewController *viewController = (CompetitionsTableViewController *) segue.destinationViewController;
    viewController.sportSelected = sportSelected;
}

#pragma mark - Actions
- (IBAction)actionOpenSport:(id)sender {
    UIButton *clickedButton = (UIButton *) sender;
    sportSelected = clickedButton.tag;
    [self performSegueWithIdentifier:@"idShowCompetitions" sender:nil];
}

- (IBAction)actionFavorites:(id)sender {
    [Utils showComingSoon];
}

#pragma mark -
/*
-(void)rewardBasedVideoAd:(GADRewardBasedVideoAd *)rewardBasedVideoAd didRewardUserWithReward:(GADAdReward *)reward {
    NSString *rewardMessage =
    [NSString stringWithFormat:@"Reward received with currency %@ , amount %lf",
     reward.type,
     [reward.amount doubleValue]];
    NSLog(rewardMessage);
}
*/

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

@end
