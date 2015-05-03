//
//  LoginViewController.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 5/3/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "LoginViewController.h"
#import "APIConnectionManager.h"

@interface LoginViewController ()

@property NSUserDefaults *defaults;
@property APIConnectionManager *api;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.defaults = [NSUserDefaults standardUserDefaults];
    self.api = [APIConnectionManager sharedConnection];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // if username stored, continue to app automatically
    
    if ([self.defaults objectForKey:@"mcdanielUsername"] != nil) {
        
        [self loginWithUsername:[self.defaults objectForKey:@"mcdanielUsername"] apiKey:[self.defaults objectForKey:@"mcdanielAPIKey"] userID:[self.defaults objectForKey:@"mcdanielUserID"]];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginWithUsername:(NSString *)username apiKey:(NSString *)apiKey userID:(NSString *)userID {
    
    // set defaults
    
    [self.defaults setObject:username forKey:@"mcdanielUsername"];
    [self.defaults setObject:userID forKey:@"mcdanielUserID"];
    [self.defaults setObject:apiKey forKey:@"mcdanielAPIKey"];
    
    // give api info

    self.api.api_key = apiKey;
    self.api.userID = userID;
    
    // show main app
    
    [self performSegueWithIdentifier:@"loginSuccessSegue" sender:self];
}

- (IBAction)loginButtonPressed:(id)sender {
    
    NSString * username = self.loginField.text;
    
    // [self.api doQuery:[NSString stringWithFormat:@"/users/login/%@", username] caller:self callback:@selector(didLogin:)];
    
    NSDictionary *data = @{ @"id":@"1", @"username":@"ajr009", @"api_key":@"ya29.LAFWYdlZwK0pO3OsRd7oCs_ZwzOB2-XMZrdj1XGwviN54CSBSkJgdanLcWqHzGl4eI0BmZ9hrKPRmg" };
    
    [self didLogin:data];
}

- (void)didLogin:(NSDictionary *)data {
    
    // successful login
    
    if ([data objectForKey:@"error"] == nil) {
        
        [self loginWithUsername:[data objectForKey:@"username"] apiKey:[data objectForKey:@"api_key"] userID:[data objectForKey:@"id"]];
        
    }else {
        
        // wrong input
        
        UIAlertController *errorAlert = [UIAlertController alertControllerWithTitle:@"Error!" message:@"That username is not recognized. Did you forget to sign up online?" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { }];
        
        [errorAlert addAction:okAction];
        [self presentViewController:errorAlert animated:YES completion:nil];
        
        self.loginField.text = @"";
        
    }
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
