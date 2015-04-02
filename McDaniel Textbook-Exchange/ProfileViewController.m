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
    
    self.mainLabel.hidden = YES;
    
    APIConnectionManager *connection = [APIConnectionManager sharedConnection];
    
    connection.api_key = @"ya29.LAFWYdlZwK0pO3OsRd7oCs_ZwzOB2-XMZrdj1XGwviN54CSBSkJgdanLcWqHzGl4eI0BmZ9hrKPRmg";
    [connection doQuery:@"/books/2/owners" caller:self callback:@selector(setLabelValue:)];
}

- (void)setLabelValue:(NSArray *)json {
    
    self.mainLabel.hidden = NO;
    
    NSLog(@"Data received:\n%@", [[json objectAtIndex:0] objectForKey:@"name"]);
    self.mainLabel.text = [[json objectAtIndex:0] objectForKey:@"name"];
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
