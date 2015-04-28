//
//  TradeTableViewCell.h
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 4/16/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TradesTableViewController.h"
#import "SWTableViewCell.h"
#import "Trade.h"

@interface TradeTableViewCell : SWTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *receivedItems;
@property (weak, nonatomic) IBOutlet UILabel *sentItems;

@property Trade *trade;
@property TradesTableViewController *controller;

-(void)loadInformation;

@end
