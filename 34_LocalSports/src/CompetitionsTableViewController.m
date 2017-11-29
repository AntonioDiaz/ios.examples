#import "CompetitionsTableViewController.h"
#import "AppDelegate.h"
#import "CompetitionEntity+CoreDataProperties.h"
#import "Utils.h"
#import "CompetitionTabBarController.h"


@implementation CompetitionsTableViewController

@synthesize sportSelected;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *townSelected = [userDefaults objectForKey:PREF_TOWN_NAME];
    NSString *sportStr = [Utils enumSportToString:sportSelected];
    self.navigationItem.title = [NSString stringWithFormat:@"%@ - %@", townSelected, sportStr];

    
    AppDelegate *app = (AppDelegate*) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = app.persistentContainer.viewContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *description = [NSEntityDescription entityForName:COMPETITION_ENTITY inManagedObjectContext:context];

    [request setEntity:description];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"sport == %@", sportStr];
    [request setPredicate:predicate];
    NSError *error;
    arrayCompetitions = [context executeFetchRequest:request error:&error];
    [self.tableView reloadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (arrayCompetitions.count == 0) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
        label.text = @"There is no competitions for this sport.";
        label.textColor = UIColorFromRGB(0x303F9F);
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont fontWithName:@"Verdana-Bold" size:22];
        self.tableView.backgroundView = label;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    } else {
        self.tableView.backgroundView  = nil;
        self.tableView.separatorStyle = UITableViewCellStyleDefault;
    }
    return arrayCompetitions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_competition" forIndexPath:indexPath];
    CompetitionEntity *competitionEntity = [arrayCompetitions objectAtIndex:indexPath.row];
    cell.textLabel.text = competitionEntity.name;
    cell.detailTextLabel.text = competitionEntity.category;
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    CompetitionTabBarController *competitionTabBarController = segue.destinationViewController;
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    CompetitionEntity *competitionEntity = [arrayCompetitions objectAtIndex:indexPath.row];
    competitionTabBarController.competitionEntity = competitionEntity;
}


@end
