//
//  WishlistTableViewController.h
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 3/3/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIConnectionManager.h"

@interface WishlistTableViewController : UITableViewController

@property APIConnectionManager *api;
@property NSMutableArray *rowData;

- (void)removeWishlistBook:(id)bookID;
@end
