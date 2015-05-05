//
//  TradeDetailViewController.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 4/21/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "TradeDetailViewController.h"

@interface TradeDetailViewController ()

@end

@implementation TradeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up information to match trade

    self.userName.text = [self.trade theirName];
    self.userEmail.text = [self.trade theirEmail];
    
    UIImage *avatar = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.trade theirImage]]]];
    
    self.userImage.image = avatar;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
