//
//  TradeTableViewCell.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 4/16/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "TradeTableViewCell.h"

@implementation TradeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)loadInformation {
    
    // set view control properties
    
    self.userName.adjustsFontSizeToFitWidth = NO;
    self.userName.numberOfLines = 1;
    
    self.receivedItems.lineBreakMode = NSLineBreakByWordWrapping;
    self.receivedItems.adjustsFontSizeToFitWidth = NO;
    
    self.sentItems.lineBreakMode = NSLineBreakByWordWrapping;
    self.sentItems.adjustsFontSizeToFitWidth = NO;
    
    // set view control values
    
    self.userName.text = [self.trade theirName];
    
    self.receivedItems.text = [[self.trade theirBook] objectForKey:@"title"];
    [self.receivedItems sizeToFit];
    
    UIImage *receivedBookImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.trade theirBook] objectForKey:@"image"]]]];
    self.receivedImage.image = receivedBookImage;
    
    self.sentItems.text = [[self.trade yourBook] objectForKey:@"title"];
    [self.sentItems sizeToFit];
    
    UIImage *sentBookImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[self.trade yourBook] objectForKey:@"image"]]]];
    self.sentImage.image = sentBookImage;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
