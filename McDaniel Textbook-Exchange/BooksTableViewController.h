//
//  BooksTableViewController.h
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 3/3/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIConnectionManager.h"
#import "SWTableViewCell.h"

@interface BooksTableViewController : UITableViewController <SWTableViewCellDelegate>

@property APIConnectionManager *api;
@property NSMutableArray *rowData;

- (NSArray *)rightButtons;

- (void)removeOwnedBook:(id)bookID;

@end
