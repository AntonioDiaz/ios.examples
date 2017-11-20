#import "AddLocationViewController.h"
#import "AppDelegate.h"

@interface AddLocationViewController ()

@end

@implementation AddLocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AppDelegate *app = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = app.persistentContainer.viewContext;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)actionLibrary:(id)sender {
}

- (IBAction)actionCamera:(id)sender {
}

- (IBAction)actionSaveLocation:(id)sender {
}
@end
