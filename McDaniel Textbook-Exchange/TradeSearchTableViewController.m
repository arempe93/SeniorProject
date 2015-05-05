//
//  TradeSearchTableViewController.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 5/1/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "TradeSearchTableViewController.h"
#import "TradeSearchTableViewCell.h"

@interface TradeSearchTableViewController ()

@property NSMutableArray *suggestionData;

@end

@implementation TradeSearchTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize api
    self.api = [APIConnectionManager sharedConnection];
    
    // initialize search bar
    self.searchBar.delegate = self;
    
    // initialize refresh control
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor darkGrayColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(refreshTrades)
                  forControlEvents:UIControlEventValueChanged];
    
    // initialize row data
    
    self.suggestionData = [[NSMutableArray alloc] init];
    
    [self refreshTrades];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)leftButtons {
    
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    
    // delete button
    
    /* #007aff */
    [leftUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0 green:0.478f blue:1 alpha:1.0]
                                                icon:[UIImage imageNamed:@"send.png"]];
    
    return leftUtilityButtons;
}

# pragma mark - Searching

- (void)refreshTrades {
    
    // get info
    [self.api doQuery:@"/users/:user/trades/suggest" caller:self callback:@selector(didFindTrades:)];
}

- (void)didFindTrades:(NSArray *)data {
    
    [self.refreshControl endRefreshing];
    
    self.suggestionData = [NSMutableArray arrayWithArray:data];
    
    [self.tableView reloadData];
}

#pragma mark - SWTableViewCell delgate

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    
    switch (index) {
        case 0:
            // Remove the record on the server
            
            
            // Remove the row from data array
            [self.suggestionData removeObjectAtIndex:indexPath.row];
            
            // Delete the row from the table
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            break;
    }
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.suggestionData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    TradeSearchTableViewCell *cell = (TradeSearchTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"tradeSearchCell" forIndexPath:indexPath];
    
    cell.leftUtilityButtons = [self leftButtons ];
        
    cell.suggestion = [self.suggestionData objectAtIndex:indexPath.row];
    [cell loadInformation];
        
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
