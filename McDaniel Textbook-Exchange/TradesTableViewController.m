//
//  TradesTableViewController.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 3/3/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "TradesTableViewController.h"
#import "TradeTableViewCell.h"
#import "Trade.h"
#import "TradeDetailViewController.h"

@interface TradesTableViewController ()

@end

@implementation TradesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // table configuration
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    // get table data
    
    self.api = [APIConnectionManager sharedConnection];
    
    // initialize refresh control
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor darkGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshTrades)
                  forControlEvents:UIControlEventValueChanged];
    
    // get table data
    [self refreshTrades];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshTrades {
    
    [self.refreshControl endRefreshing];
    
    [self.api doQuery:@"/users/:user/trades" caller:self callback:@selector(didRowDataLoad:)];
}

#pragma mark - SWTableViewCell buttons

- (NSArray *) leftButtons {
    
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    /* #007aff */
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0 green:0.478f blue:1 alpha:1.0]
                                                icon:[UIImage imageNamed:@"check.png"]];
    
    return leftUtilityButtons;
}

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
    
    NSLog(@"%@", self.rowData);
    
    [self.tableView reloadData];
}

#pragma mark - SWTableViewCell delgate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    switch (index) {
        case 0:
            // Approve the trade
            [self approveTrade:[[self.rowData objectAtIndex:indexPath.row] objectForKey:@"id"]];
            
            // Remove the row from data array
            [self.rowData removeObjectAtIndex:indexPath.row];
            
            // Delete the row from the table
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    switch (index) {
        case 0:
            // Remove the record on the server
            [self declineTrade:[[self.rowData objectAtIndex:indexPath.row] objectForKey:@"id"]];
            
            // Remove the row from data array
            [self.rowData removeObjectAtIndex:indexPath.row];
            
            // Delete the row from the table
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            break;
        default:
            break;
    }
}

- (void)approveTrade:(id)tradeID {
    
    [self.api doQuery:[NSString stringWithFormat:@"/trades/%@/approve", tradeID] caller:self callback:@selector(tradeApproved:)];
}

- (void)tradeApproved:(NSDictionary *)data {
    
    UIAlertController *tradeAlert = [UIAlertController alertControllerWithTitle:@"Success!" message:@"An email was sent to both of you to set up the exchange" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { }];
    
    [tradeAlert addAction:okAction];
    [self presentViewController:tradeAlert animated:YES completion:nil];
}

- (void)declineTrade:(id)tradeID {
    
    [self.api doDelete:[NSString stringWithFormat:@"/trades/%@", tradeID]];
    
    UIAlertController *tradeAlert = [UIAlertController alertControllerWithTitle:@"Declined!" message:@"Looked like a bad deal anyway" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { }];
    
    [tradeAlert addAction:okAction];
    [self presentViewController:tradeAlert animated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.rowData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TradeTableViewCell *cell = (TradeTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"tradeCell" forIndexPath:indexPath];
    
    Trade *trade = [[Trade alloc] initWithDict:[self.rowData objectAtIndex:indexPath.row]];
    
    cell.delegate = self;
    cell.controller = self;

    cell.leftUtilityButtons = [self leftButtons];
    cell.rightUtilityButtons = [self rightButtons];
    
    cell.trade = trade;
    [cell loadInformation];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Trade *trade = ((TradeTableViewCell *) [tableView cellForRowAtIndexPath:indexPath]).trade;
    
    //[self performSegueWithIdentifier:@"showTradeDetail" sender:trade];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([sender isKindOfClass:[Trade class]]) {
    
        TradeDetailViewController *destination = (TradeDetailViewController *) [segue destinationViewController];
        destination.trade = (Trade *) sender;
    }
}


@end
