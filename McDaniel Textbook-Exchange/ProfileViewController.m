//
//  ProfileViewController.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 3/10/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "ProfileViewController.h"
#import "APIConnectionManager.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    APIConnectionManager *connection = [APIConnectionManager sharedConnection];
    
    connection.api_key = @"ya29.LAFyYRdSMyFevoTBlGcaConwlW0udHoruAJESuXTByWZLgtCPaveeodiJKRb7khu7RW-g47R0LoVvQ";
    [connection doQuery:@"/books/1/owners" params:@"?blah=1" caller:self callback:@selector(setLabelValue:)];
}

- (void)setLabelValue:(NSMutableData *)data {
    
    NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    
    self.mainLabel.text = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
