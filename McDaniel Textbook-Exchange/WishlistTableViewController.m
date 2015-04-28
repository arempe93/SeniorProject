//
//  WishlistTableViewController.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 3/3/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "WishlistTableViewController.h"
#import "WishlistTableViewCell.h"
#import "APIConnectionManager.h"

@interface WishlistTableViewController ()

@end

@implementation WishlistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // table configuration
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    // initialize api
    
    self.api = [APIConnectionManager sharedConnection];
    self.api.api_key = @"ya29.LAFWYdlZwK0pO3OsRd7oCs_ZwzOB2-XMZrdj1XGwviN54CSBSkJgdanLcWqHzGl4eI0BmZ9hrKPRmg";
    
    // initialize refresh control
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor darkGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshWishlist)
                  forControlEvents:UIControlEventValueChanged];
    
    // get table data
    
    [self refreshWishlist];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshWishlist {
    
    [self.refreshControl endRefreshing];
    
    [self.api doQuery:@"/users/1/wanted_books" caller:self callback:@selector(didRowDataLoad:)];
}

#pragma mark - SWTableViewCell buttons

- (NSArray *) leftButtons {
    
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor: /* #007aff */
     [UIColor colorWithRed:0 green:0.478f blue:1 alpha:1.0] title:@"1"];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor: /* #ffcc00 */
     [UIColor colorWithRed:1 green:0.8f blue:0 alpha:1.0] title:@"2"];
    
    return leftUtilityButtons;
}

- (NSArray *) rightButtons {
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    // delete button
    [rightUtilityButtons sw_addUtilityButtonWithColor: /* #ff2d55 */
     [UIColor colorWithRed:1 green:0.176f blue:0.333f alpha:1.0] title:@"X"];
    
    return rightUtilityButtons;
}

#pragma mark - Asynchronous data loading

- (void)didRowDataLoad:(NSArray *)data {
    
    self.rowData = [NSMutableArray arrayWithArray:data];

    [self.tableView reloadData];
}

#pragma mark - Cell actions

- (void)removeWishlistBook:(id)bookID {
    
    [self.api doDelete:[NSString stringWithFormat:@"/wanted_books/%@", bookID]];
}

#pragma mark - SWTableViewCell delgate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    switch (index) {
        case 0:
            NSLog(@"check button was pressed");
            break;
        case 1:
            NSLog(@"clock button was pressed");
            break;
        case 2:
            NSLog(@"cross button was pressed");
            break;
        case 3:
            NSLog(@"list button was pressed");
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    switch (index) {
        case 0:
            // Remove the record on the server
            [self removeWishlistBook:[[self.rowData objectAtIndex:indexPath.row] objectForKey:@"id"]];
            
            // Remove the row from data array
            [self.rowData removeObjectAtIndex:indexPath.row];
            
            // Delete the row from the table
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.rowData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WishlistTableViewCell *cell = (WishlistTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"wishlistCell" forIndexPath:indexPath];
    
    cell.delegate = self;
    
    cell.leftUtilityButtons = [self leftButtons];
    cell.rightUtilityButtons = [self rightButtons];
    
    cell.cellInformation = [[self.rowData objectAtIndex:indexPath.row] objectForKey:@"book"];
    [cell loadInformation];
    
    cell.controller = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // height of cell content view
    return 175;
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return NO;
}

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
 
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
