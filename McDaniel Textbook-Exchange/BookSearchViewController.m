//
//  BookSearchViewController.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 4/28/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "BookSearchViewController.h"
#import "APIConnectionManager.h"
#import "WishlistTableViewController.h"
#import "BooksTableViewController.h"

@interface BookSearchViewController ()

@end

@implementation BookSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // initialize api
    
    self.api = [APIConnectionManager sharedConnection];
    self.api.api_key = @"ya29.LAFWYdlZwK0pO3OsRd7oCs_ZwzOB2-XMZrdj1XGwviN54CSBSkJgdanLcWqHzGl4eI0BmZ9hrKPRmg";
    
    // hide detail view for now
    
    [self.detailView setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Search actions

- (IBAction)bookSearch:(id)sender {
    
    [self.view endEditing:YES];

    NSString * isbn = self.searchField.text;
    
    [self.api doQuery:[NSString stringWithFormat:@"/books/find/%@", isbn] caller:self callback:@selector(foundBook:)];
}

- (void)foundBook:(NSDictionary *)data {
    
    // store this books data
    
    self.currentBook = data;
    
    // show details
    
    self.bookTitle.text = [data objectForKey:@"title"];
    self.bookAuthors.text = [data objectForKey:@"authors"];
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[data objectForKey:@"image"]]]];
    self.bookImage.image = image;
    
    // show hidden view
    [self.detailView setHidden:NO];
}

- (IBAction)addBook:(id)sender {
    
    // send current book info to appropriate list
    
    if ([self.sender isKindOfClass:[WishlistTableViewController class]]) {
        
        
    }else {
        
    }
    
    UIAlertController *addAlert = [UIAlertController alertControllerWithTitle:@"Awesome!" message:@"The book was added to your list" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) { [self unwind:nil]; }];
    
    [addAlert addAction:okAction];
    [self presentViewController:addAlert animated:YES completion:nil];
}

- (void)didAddBook {
    
    
}

- (IBAction)clearBook:(id)sender {
    
}

- (IBAction)unwind:(id)sender {
    
    self.currentBook = nil;
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
