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
    
    self.userName.hidden = YES;
    self.userEmail.hidden = YES;
    
    APIConnectionManager *connection = [APIConnectionManager sharedConnection];
    
    [connection doQuery:@"/users/:user" caller:self callback:@selector(setLabelValue:)];
}

- (void)setLabelValue:(NSDictionary *)data {
    
    self.userName.hidden = NO;
    self.userEmail.hidden = NO;
    
    self.userName.text = [data objectForKey:@"name"];
    self.userEmail.text = [data objectForKey:@"email"];
    
    UIImage *avatar = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectForKey:@"image"]]]];
    self.userImage.image = avatar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButtonPressed:(id)sender {
    
    // clear user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults removeObjectForKey:@"mcdanielUsername"];
    [defaults removeObjectForKey:@"mcdanielAPIKey"];
    [defaults removeObjectForKey:@"mcdanielUserID"];
    
    // return to login page
    [self presentViewController:[self.storyboard instantiateInitialViewController] animated:YES completion:nil];
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
