//
//  APIConnectionManager.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 3/10/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "APIConnectionManager.h"

@implementation APIConnectionManager

#pragma mark - Singleton methods

+ (APIConnectionManager *)sharedConnection {
    
    // shared instance
    static APIConnectionManager *instance = nil;
    
    // use Grand Central Dispatch to initialize only once
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (APIConnectionManager *)init {
    
    self = [super init];
    
    self.connection = [[NSURLConnection alloc] init];
    self.endpoint = [[NSURLComponents alloc] init];
    self.data = [NSMutableData dataWithLength:0];
    
    self.api_key = [[NSString alloc] init];
    
    self.endpoint.scheme = @"http";
    self.endpoint.host = @"mcdaniel-textbook-exchange.herokuapp.com";
    
    return self;
}

#pragma mark - Instance methods

- (void)doQuery:(NSString*)path caller:(id)caller callback:(SEL)callback {
    
    // do query with dummy params
    [self doQueryWithParams:path caller:caller callback:callback params:@"foo=bar"];
}

- (void)doQueryWithParams:(NSString*)path caller:(id)caller callback:(SEL)callback params:(NSString*)params {
    
    // set callback
    self.caller = caller;
    self.callback = callback;
    
    // modify url
    self.endpoint.path = path;
    self.endpoint.query = [params stringByAppendingString:[NSString stringWithFormat:@"&key=%@", self.api_key]];
    
    NSLog(@"Connection url:");
    NSLog(@"%@", self.endpoint.URL);
    
    
    // create some storage for the result
    self.data = [NSMutableData dataWithCapacity:0];
    
    // create the request
    NSURLRequest *request = [NSURLRequest requestWithURL:self.endpoint.URL];
    self.connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    // start the connection
    self.connection.start;
    NSLog(@"Connection started...");
}

- (void)doDelete:(NSString *)path {
    
}

#pragma mark - Connection delegate methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
    NSLog(@"Response received");
    
    [self.data setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)receivedData {
    
    [self.data appendData:receivedData];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    NSLog(@"Connection completed.");
    
    // send data to callback
    [self.caller performSelector:self.callback withObject:[NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableLeaves error:nil]];
    
    // release connection and data
    self.connection = nil;
    self.data = nil;
}

@end
