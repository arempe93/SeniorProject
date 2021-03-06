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
#import "BookSearchViewController.h"

@interface WishlistTableViewController ()

@end

@implementation WishlistTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // table configuration
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    // initialize api
    
    self.api = [APIConnectionManager sharedConnection];
    
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
    
    [self.api doQuery:@"/users/:user/wanted_books" caller:self callback:@selector(didRowDataLoad:)];
}

#pragma mark - SWTableViewCell buttons

- (NSArray *) rightButtons {
    
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    
    // delete button
    
    /* #ff2d55 */
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1 green:0.176f blue:0.333f alpha:1.0]
                                                 icon:[UIImage imageNamed:@"cross.png"]];
    
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqual:@"wishlistSearchSegue"]) {
        
        BookSearchViewController *destination = (BookSearchViewController *)[[segue destinationViewController] viewControllers][0];
        
        destination.sender = self;
    }
}


@end
