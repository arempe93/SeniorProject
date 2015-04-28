//
//  TradeDetailViewController.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 4/21/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "TradeDetailViewController.h"

@interface TradeDetailViewController ()

@end

@implementation TradeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // set up information to match trade
    
    self.userName.text = [[self.trade.tradeData objectForKey:@"sender"] objectForKey:@"name"];
    self.userEmail.text = [[self.trade.tradeData objectForKey:@"sender"] objectForKey:@"email"];
    
    UIImage *avatar = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg"]]];
    
    self.userImage.image = avatar;
    
    // create table
    
    self.booksTable = [[UITableView alloc] initWithFrame:CGRectMake(45, 275, 300, 300)];
    self.booksTable.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.booksTable.translatesAutoresizingMaskIntoConstraints = NO;
    
    // configure table data source
    
    self.booksTable.delegate = self;
    self.booksTable.dataSource = self;
    [self.booksTable registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    [self.view addSubview:self.booksTable];
    
    // table constraints
    
    NSDictionary *viewsDict = @{@"booksTable":self.booksTable, @"userImage":self.userImage};
    
    NSArray *heightConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[booksTable(400)]"
                                                                     options:0 metrics:nil
                                                                       views:viewsDict];
    
    NSArray *topConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[userImage]-30-[booksTable]"
                                                                     options:0 metrics:nil
                                                                       views:viewsDict];
    
    NSArray *leftConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-16-[booksTable]"
                                                                      options:0 metrics:nil
                                                                        views:viewsDict];
    
    NSArray *rightConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[booksTable]-16-|"
                                                                       options:0 metrics:nil
                                                                         views:viewsDict];
    [self.view addConstraint:[topConstraint objectAtIndex:0]];
    [self.view addConstraint:[leftConstraint objectAtIndex:0]];
    [self.view addConstraint:[rightConstraint objectAtIndex:0]];
    [self.view addConstraint:[heightConstraint objectAtIndex:0]];
    
    // fill table data variables
    
    self.sections = [NSArray arrayWithObjects:[self.trade yourBooks], [self.trade theirBooks], nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // your books and their books
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [[self.sections objectAtIndex:section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return @"Your books";
    }else {
        return @"Their books";
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
        return @"+ $10.00";
    }else {
        return @"+ $0.00";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSDictionary *book = [[self.sections objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [book objectForKey:@"title"];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0;
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
