//
//  TradeSearchTableViewCell.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 5/1/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "TradeSearchTableViewCell.h"

@implementation TradeSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)loadInformation {
    
    // set view control properties
    
    self.userName.adjustsFontSizeToFitWidth = NO;
    self.userName.numberOfLines = 1;
    
    // set view control values
    
    UIImage *theirImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ecx.images-amazon.com/images/I/31s1KcxycvL._SL194_.jpg"]]];
    self.theirBook.image = theirImage;
    
    UIImage *yourImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ecx.images-amazon.com/images/I/51yoKYI9r3L._SL194_.jpg"]]];
    self.yourBook.image = yourImage;
    
    self.exchangeImage.image = [UIImage imageNamed:@"check.png"];
    
    self.userName.text = [self.suggestion valueForKeyPath:@"user.name"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
