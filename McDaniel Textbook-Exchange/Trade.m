//
//  Trade.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 4/9/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "Trade.h"

@implementation Trade

-(id) initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    
    self.tradeData = dict;
    
    // build information for previous trade if there is one
    if (![[self.tradeData objectForKey:@"counter_offer"] isEqual:[NSNull null]]) {
        
        self.previous_offer = [[Trade alloc] initWithDict:[self.tradeData objectForKey:@"counter_offer"]];
        
        [self doComparison];
    }
    
    return self;
}

-(BOOL)hasPreviousTrade {
    
    return !self.previous_offer;
}

-(void) doComparison {
    
    // compare this trade to the previous
    self.comparison = [[NSMutableArray alloc] init];
    
    // sender book differences
    NSArray *current_sender_books = [self.tradeData objectForKey:@"sender_books"];
    NSArray *previous_sender_books = [self.previous_offer.tradeData objectForKey:@"sender_books"];
    
    for (id book in previous_sender_books) {
        if ([current_sender_books indexOfObject:book] == NSNotFound) {
            [self.comparison addObject:[NSString stringWithFormat:@"Sender removed book with id: %@", book]];
        }
    }
    
    for (id book in current_sender_books) {
        if ([previous_sender_books indexOfObject:book] == NSNotFound) {
            [self.comparison addObject:[NSString stringWithFormat:@"Sender added book with id: %@", book]];
        }
    }
    
    // receiver book differences
    NSArray *current_receiver_books = [self.tradeData objectForKey:@"receiver_books"];
    NSArray *previous_receiver_books = [self.previous_offer.tradeData objectForKey:@"receiver_books"];
    
    for (id book in previous_receiver_books) {
        if ([current_receiver_books indexOfObject:book] == NSNotFound) {
            [self.comparison addObject:[NSString stringWithFormat:@"Receiver removed book with id: %@", book]];
        }
    }
    
    for (id book in current_receiver_books) {
        if ([previous_receiver_books indexOfObject:book] == NSNotFound) {
            [self.comparison addObject:[NSString stringWithFormat:@"Receiver added book with id: %@", book]];
        }
    }
    
    // sender extra differences
    float current_sender_extras = [[self.tradeData objectForKey:@"sender_extras"] floatValue];
    float previous_sender_extras = [[self.previous_offer.tradeData objectForKey:@"sender_extras"] floatValue];
    
    float sender_difference = current_sender_extras - previous_sender_extras;
    
    if(sender_difference != 0 && sender_difference > 0) {
        
        [self.comparison addObject:[NSString stringWithFormat:@"Sender added $%f", fabsf(sender_difference)]];
    
    }else if (sender_difference != 0) {
        
        [self.comparison addObject:[NSString stringWithFormat:@"Sender removed $%f", fabsf(sender_difference)]];
    }
    
    // receiver extra differences
    float current_receiver_extras = [[self.tradeData objectForKey:@"receiver_extras"] floatValue];
    float previous_receiver_extras = [[self.previous_offer.tradeData objectForKey:@"receiver_extras"] floatValue];
    
    float receiver_difference = current_receiver_extras - previous_receiver_extras;
    
    if(receiver_difference != 0 && receiver_difference > 0) {
        
        [self.comparison addObject:[NSString stringWithFormat:@"Receiver added $%f", fabsf(receiver_difference)]];
        
    }else if (receiver_difference != 0) {
        
        [self.comparison addObject:[NSString stringWithFormat:@"Receiver removed $%f", fabsf(receiver_difference)]];
    }
}

-(NSMutableArray *)compareToPrevious {
    
    return self.comparison;
}

@end
