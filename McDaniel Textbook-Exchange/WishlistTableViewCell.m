//
//  WishlistTableViewCell.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 3/24/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "WishlistTableViewCell.h"
#import "WishlistTableViewController.h"

@implementation WishlistTableViewCell

- (void)awakeFromNib {
    
}

- (void)loadInformation {
    
    // set view control properties
    
    self.bookName.lineBreakMode = NSLineBreakByWordWrapping;
    self.bookName.adjustsFontSizeToFitWidth = NO;
    self.bookName.numberOfLines = 2;
    
    self.bookAuthor.lineBreakMode = NSLineBreakByWordWrapping;
    self.bookAuthor.adjustsFontSizeToFitWidth = NO;
    self.bookAuthor.numberOfLines = 2;
    
    // set view control values
    
    UIImage *sampleImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[self.cellInformation objectForKey:@"image"]]]];
    
    self.bookImage.image = sampleImage;
    
    self.bookName.text = [self.cellInformation objectForKey:@"title"];
    [self.bookName sizeToFit];
    
    self.bookAuthor.text = [self.cellInformation objectForKey:@"authors"];
    [self.bookAuthor sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // configure the view for the selected state
}

@end
