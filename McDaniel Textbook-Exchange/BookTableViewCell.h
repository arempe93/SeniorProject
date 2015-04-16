//
//  BookTableViewCell.h
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 4/6/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BooksTableViewController.h"
#import "SWTableViewCell.h"

@interface BookTableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;

@property NSDictionary *cellInformation;
@property BooksTableViewController *controller;

-(void) loadInformation;

@end
