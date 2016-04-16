//
//  LQVedioViewController.m
//  Spice
//
//  Created by lanou3g on 16/4/14.
//  Copyright © 2016年 spice. All rights reserved.
//

#import "LQVedioViewController.h"

@interface LQVedioViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation LQVedioViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    return cell;
}


@end
