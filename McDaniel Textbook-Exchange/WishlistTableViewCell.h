//
//  WishlistTableViewCell.h
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 3/24/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WishlistTableViewController.h"
#import "SWTableViewCell.h"

@interface WishlistTableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *bookName;
@property (weak, nonatomic) IBOutlet UILabel *bookAuthor;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;

@property NSDictionary *cellInformation;
@property WishlistTableViewController *controller;

-(void) loadInformation;
@end
