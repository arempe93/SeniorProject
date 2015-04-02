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
    
    // get table data
    
    self.api = [APIConnectionManager sharedConnection];
    self.api.api_key = @"ya29.NAF4ZwvPzzpOJBB7pdoajHDZCug9oT1v_7M8NvfPBchTSdaUhCZI6GT3cKbMZcOAJN9nCi6uNRhTsQ";
    
    [self.api doQuery:@"/users/1/owned_books" caller:self callback:@selector(didRowDataLoad:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Asynchronous data loading

- (void)didRowDataLoad:(NSArray *)data {
    
    self.rowData = [NSMutableArray arrayWithArray:data];

    [self.tableView reloadData];
}

#pragma mark - Cell actions

- (void)removeWishlistBook:(id)bookID {
    
    [self.api doDelete:[NSString stringWithFormat:@"/owned_books/%@", bookID]];
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
    
    cell.cellInformation = [self.rowData objectAtIndex:indexPath.row];
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
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // Remove the record on the server
        
        [self removeWishlistBook:[[self.rowData objectAtIndex:indexPath.row] objectForKey:@"id"]];
        
        // Remove the row from data array
        
        [self.rowData removeObjectAtIndex:indexPath.row];
        
        // Delete the row from the table
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

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
