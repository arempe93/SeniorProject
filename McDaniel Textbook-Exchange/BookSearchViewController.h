//
//  BookSearchViewController.h
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 4/28/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APIConnectionManager.h"

@interface BookSearchViewController : UIViewController

@property APIConnectionManager *api;

@property UITableViewController *sender;

@property NSDictionary *currentBook;

@property (weak, nonatomic) IBOutlet UITextField *searchField;

@property (weak, nonatomic) IBOutlet UIView *detailView;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthors;
@property (weak, nonatomic) IBOutlet UIButton *clearButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;


- (void)foundBook:(NSDictionary *)data;

@end
