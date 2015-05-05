//
//  MainTabsViewController.m
//  McDaniel Textbook-Exchange
//
//  Created by ajr009 on 5/5/15.
//  Copyright (c) 2015 Rempire. All rights reserved.
//

#import "MainTabsViewController.h"

@interface MainTabsViewController ()

@end

@implementation MainTabsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                        NSForegroundColorAttributeName : [UIColor whiteColor]
                                                        } forState:UIControlStateSelected];
    
    
    // doing this results in an easier to read unselected state then the default iOS 7 one
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:10.0f],
                                                        NSForegroundColorAttributeName : [UIColor colorWithRed:.5 green:.5 blue:.5 alpha:1]
                                                        } forState:UIControlStateNormal];
    
    ((UITabBarItem *) self.tabBar.items[0]).selectedImage = [[UIImage imageNamed:@"book.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ((UITabBarItem *) self.tabBar.items[1]).selectedImage = [[UIImage imageNamed:@"heart.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ((UITabBarItem *) self.tabBar.items[2]).selectedImage = [[UIImage imageNamed:@"exchange.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    ((UITabBarItem *) self.tabBar.items[3]).selectedImage = [[UIImage imageNamed:@"user.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
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
