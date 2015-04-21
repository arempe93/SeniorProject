//
//  TradeDetailViewController.h
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 4/21/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Trade.h"

@interface TradeDetailViewController : UIViewController

@property Trade *trade;

@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userEmail;
@end
