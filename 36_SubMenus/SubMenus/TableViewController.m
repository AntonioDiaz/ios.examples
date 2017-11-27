#import "TableViewController.h"

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    sectionsExpanded = [[NSMutableIndexSet alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self tableView:tableView canCollpseSection:section]) {
        if ([sectionsExpanded containsIndex:section]) {
            return 5;
        } else {
            return 1;
        }
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"my_cell" forIndexPath:indexPath];
    if ([self tableView:tableView canCollpseSection:indexPath.section]) {
        if(indexPath.row == 0) {
            //si queremos mostrar un icono a la derecha dependiendo de si esta desplegado o no el menu.
            if([sectionsExpanded containsIndex:indexPath.section]) {
               cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else {
               cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            cell.textLabel.text= @"MENU";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        } else {
            cell.textLabel.text = @"SUB_MENU";
        }
    } else {
        cell.textLabel.text = @"MENU NO SUBMENU";
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self tableView: tableView canCollpseSection:indexPath.section]) {
        if (indexPath.row == 0) {
            //unselect cell.
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
        NSInteger section = indexPath.section;
        
        NSMutableArray *mutableArrayCells = [[NSMutableArray alloc] init];
        for (int i=1; i<5; i++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:section];
            [mutableArrayCells addObject:indexPath];
        }
        
        if ([sectionsExpanded containsIndex:section]) {
            [sectionsExpanded removeIndex:section];
            [tableView deleteRowsAtIndexPaths:mutableArrayCells withRowAnimation:UITableViewRowAnimationTop];
        } else {
            [sectionsExpanded addIndex:section];
            [tableView insertRowsAtIndexPaths:mutableArrayCells withRowAnimation:UITableViewRowAnimationTop];
        }
    }
}

#pragma mark - private methds
-(BOOL) tableView:(UITableView*) tableView canCollpseSection: (NSInteger) section {
    if (section == 0) {
        return false;
    } else {
        return true;
    }
}


@end
