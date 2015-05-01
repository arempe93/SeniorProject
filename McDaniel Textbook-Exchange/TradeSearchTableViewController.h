//
//  TradeSearchTableViewController.h
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 5/1/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIConnectionManager.h"

@interface TradeSearchTableViewController : UITableViewController <UISearchBarDelegate>

@property APIConnectionManager *api;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

- (void)refreshTrades;
- (void)didFindTrades:(NSArray *)data;

- (void)searchBooks;
- (void)didFindBook:(NSDictionary *)data;

@end
