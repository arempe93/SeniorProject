//
//  WishlistTableViewCell.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 3/24/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "WishlistTableViewCell.h"

@implementation WishlistTableViewCell

- (void)awakeFromNib {
    
}

- (void)loadInformation {
    
    NSLog(@"Wishlist Cell Created with title: %@", [self.cellInformation objectForKey:@"title"]);
    
    // set view control properties
    
    self.bookName.lineBreakMode = NSLineBreakByWordWrapping;
    self.bookName.adjustsFontSizeToFitWidth = NO;
    self.bookName.numberOfLines = 2;
    
    // set view control values
    
    UIImage *sampleImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.cellInformation objectForKey:@"image"]]]];
    
    self.bookImage.image = sampleImage;
    
    self.bookName.text = [self.cellInformation objectForKey:@"title"];
    [self.bookName sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
