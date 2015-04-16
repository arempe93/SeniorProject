//
//  Trade.h
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 4/9/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trade : NSObject

@property NSDictionary *tradeData;
@property Trade *previous_offer;
@property NSMutableArray *comparison;

-(id)initWithDict:(NSDictionary *)dict;

-(BOOL)hasPreviousTrade;
-(NSMutableArray *)compareToPrevious;

@end