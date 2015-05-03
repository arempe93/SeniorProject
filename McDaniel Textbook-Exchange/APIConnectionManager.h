//
//  APIConnectionManager.h
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 3/10/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConnectionManager : NSObject

@property NSURLComponents *endpoint;
@property NSMutableData *data;
@property NSURLConnection *connection;

@property id caller;
@property SEL callback;

@property NSString *userID;
@property NSString *api_key;

+ (id)sharedConnection;

- (void)doQuery:(NSString *)path caller:(id)caller callback:(SEL)callback;

- (void)doQueryWithParams:(NSString *)path caller:(id)caller callback:(SEL)callback params:(NSString *)params;

- (void)doDelete:(NSString *)path;

- (void)doPost:(NSString *)path caller:(id)caller callback:(SEL)callback params:(NSString *)params;

@end
