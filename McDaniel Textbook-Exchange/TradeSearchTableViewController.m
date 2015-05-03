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
@property NSMutableArray *searchData;

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
    self.searchData = [[NSMutableArray alloc] init];
    
    [self refreshTrades];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Searching

- (void)refreshTrades {
    
    // get info
    [self.api doQuery:@"/users/:user/trades/suggest" caller:self callback:@selector(didFindTrades:)];
}

- (void)didFindTrades:(NSArray *)data {
    
    [self.refreshControl endRefreshing];
    
    self.suggestionData = [NSMutableArray arrayWithArray:data];
    
    NSLog(@"%@", [self.suggestionData objectAtIndex:0]);
    
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self.refreshControl beginRefreshing];
}

- (void)searchBooks {
    
    
}

- (void)didFindBook:(NSDictionary *)data {
    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return [self.suggestionData count];
    
    }else {
        
        return [self.searchData count];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return @"Suggestions";
    }else {
        return @"Search Results";
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        TradeSearchTableViewCell *cell = (TradeSearchTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"tradeSearchCell" forIndexPath:indexPath];
        
        cell.suggestion = [self.suggestionData objectAtIndex:indexPath.row];
        [cell loadInformation];
        
        return cell;
        
    }else {
     
        return [tableView dequeueReusableCellWithIdentifier:@"tradeSearchCell" forIndexPath:indexPath];
    }
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
