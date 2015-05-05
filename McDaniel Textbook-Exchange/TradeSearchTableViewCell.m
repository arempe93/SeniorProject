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
    
    NSDictionary *theirBookInfo = [[self.suggestion objectForKey:@"their_books"] objectAtIndex:0];
    NSDictionary *yourBookInfo = [[self.suggestion objectForKey:@"your_books"] objectAtIndex:0];
    
    UIImage *theirImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[theirBookInfo valueForKeyPath:@"book.image"]]]];
    self.theirBook.image = theirImage;
    self.theirBookName.text = [theirBookInfo valueForKeyPath:@"book.title"];
    
    UIImage *yourImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[yourBookInfo valueForKeyPath:@"book.image"]]]];
    self.yourBook.image = yourImage;
    self.yourBookName.text = [yourBookInfo valueForKeyPath:@"book.title"];
    
    self.userName.text = [self.suggestion valueForKeyPath:@"user.name"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
