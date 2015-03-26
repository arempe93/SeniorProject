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
    
    // set view control properties
    
    self.bookName.lineBreakMode = NSLineBreakByWordWrapping;
    self.bookName.adjustsFontSizeToFitWidth = NO;
    self.bookName.numberOfLines = 2;
    
    // set view control values
    
    UIImage *sampleImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ecx.images-amazon.com/images/I/416PMQqyT4L._SL194_.jpg"]]];
    
    self.bookImage.image = sampleImage;
    
    self.bookName.text = @"Calculus, 6th Edition (Stewart's Calculus Series) (Available 2010 Titles Enhanced Web Assign)";
    [self.bookName sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
