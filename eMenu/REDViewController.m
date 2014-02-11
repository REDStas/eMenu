//
//  REDViewController.m
//  eMenu
//
//  Created by Станислав Редреев on 28.05.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import "REDViewController.h"
#import "REDOrderCell.h"

@interface REDViewController ()

@end

@implementation REDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    REDOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"REDOrderCell" owner:self options:nil];
        cell = (REDOrderCell *)[nib objectAtIndex:0];
    }

    [cell setStyle];
    
    return cell;
}

- (IBAction)Button:(id)sender {
    dishDetailView = [[REDDishDetail alloc] init];
    [self.view addSubview:dishDetailView.view];
}

@end
