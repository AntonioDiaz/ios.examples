//
//  FirstViewController.m
//  favorites
//
//  Created by cice on 3/11/17.
//  Copyright © 2017 cice. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actionAddFavorite:(id)sender {
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    NSLog(@"%d" , [app.favorites getFavoritesCount]);
    NSString *title = @"Manage favorites";
    UIActionSheet *actions = [[UIActionSheet alloc] initWithTitle:title delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:@"Add Favorite" otherButtonTitles:@"Facebook", @"Twitter", @"Email", nil];
    [actions showInView:self.view];

}

- (IBAction)actionOpenUrl:(id)sender {
    NSString *urlString = self.textFieldUrl.text;
    if ([urlString length] == 0){
        NSString *errorUrlEmptyTitle = @"Url is empty.";
        NSString *errorUrlEmptyMessage = @"Please type an url.";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:errorUrlEmptyTitle
                                                            message:errorUrlEmptyMessage
                                                           delegate:self
                                                  cancelButtonTitle:@"close" otherButtonTitles: nil];
        [alertView show];
    } else {
        NSURL *url = [NSURL URLWithString: urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webViewPage loadRequest:request];
    }
}

#pragma mark UIActionSheetDelegate methods
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *clickedButton = [actionSheet buttonTitleAtIndex:buttonIndex];
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    //FavoriteEntity favoriteEntity = [FavoriteEntity initFavorite: ""]:
    //[app.favorites addFavorite:favorite];
    NSLog(@"Button %@", clickedButton);
}


- (IBAction)changeHideBar:(id)sender {
    if ([self.switchShowBar isOn]) {
        self.viewNavbar.hidden = false;
    } else {
        self.viewNavbar.hidden = true;
    }
}
@end
