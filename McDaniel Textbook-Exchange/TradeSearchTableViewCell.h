//
//  TradeSearchTableViewCell.h
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 5/1/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWTableViewCell.h"

@interface TradeSearchTableViewCell : SWTableViewCell

@property NSDictionary *suggestion;

@property (weak, nonatomic) IBOutlet UIImageView *theirBook;
@property (weak, nonatomic) IBOutlet UIImageView *yourBook;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *exchangeImage;

- (void)loadInformation;

@end
