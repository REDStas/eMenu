//
//  REDCollectionMenu.m
//  eMenu
//
//  Created by Станислав Редреев on 12.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import "REDCollectionMenu.h"

@interface REDCollectionMenu ()

@end

@implementation REDCollectionMenu

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)refreshDataWithParametersCountInLine:(int)countInLine resourceData:(NSDictionary *)data
{
    resourceData = [data copy];
    resourceDataKeys = [[NSMutableArray alloc] initWithArray:[resourceData allKeys]];
    objectsInRow = countInLine;
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return  120.0;
    }
    else
    {
        return 185.0;
    }    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [resourceDataKeys count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *textColor = [[REDOrder sharedIndicatorFiles] color_text];
    
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 746, 30)];
    UILabel *sectionTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 746, 24)];
    [sectionTitle setText:[NSString stringWithFormat:@"%@", [resourceDataKeys objectAtIndex:section]]];
    [sectionTitle setFont:[UIFont fontWithName:@"Roboto-Light" size:18.0]];
    [sectionTitle setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [sectionTitle setBackgroundColor:[UIColor clearColor]];
    [sectionTitle setShadowColor:[UIColor colorWithRed:64.0/255 green:65.0/255 blue:66.0/255 alpha:1.0]];
    [sectionTitle setShadowOffset:CGSizeMake(0, 1)];
    
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"collectionHeaderCellFon"]];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        [line setFrame:CGRectMake(5, 0, 310, 24)];
    }
    else
    {
        [line setFrame:CGRectMake(5, 0, 746, 24)];
    }
    
    [sectionView addSubview:line];
    [sectionView addSubview:sectionTitle];
    
    if ([resourceDataKeys count] == 1) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            return sectionView;;
        }
        else
        {
            return nil;
        }
    }
    else 
    {
        return sectionView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([resourceDataKeys count] == 1) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            return 32.0;
        }
        else
        {
            return 0.0;
        }
    }
    else
    {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            return 32.0;
        }
        else
        {
            return 40.0;
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int countInLine = objectsInRow;
    int tempRowCount = [[resourceData objectForKey:[resourceDataKeys objectAtIndex:section]] count] / countInLine;
    if (!((tempRowCount * countInLine) == [[resourceData objectForKey:[resourceDataKeys objectAtIndex:section]] count])) {
        tempRowCount += 1;
    }
    rowCount = tempRowCount;
    return rowCount;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *allSubCatKeys = [[NSArray alloc] initWithArray:[resourceData allKeys]];
    NSDictionary *allProductsOfSubCat = [[NSDictionary alloc] initWithDictionary:[resourceData objectForKey:[allSubCatKeys objectAtIndex:[indexPath section]]] copyItems:YES];
    NSArray *allProductsOfSubCat_Keys = [allProductsOfSubCat allKeys];
    NSMutableArray *allSeparateProductsOfSubCat = [[NSMutableArray alloc] init];
    for (int k = 0; k < [allProductsOfSubCat_Keys count]; k++) {
        [allSeparateProductsOfSubCat addObject:[allProductsOfSubCat objectForKey:[allProductsOfSubCat_Keys objectAtIndex:k]]];
    }
    NSArray *tempArray = [[NSArray alloc] init];
    int startRange = [indexPath row] * objectsInRow;
    if (([allSeparateProductsOfSubCat count] - ([indexPath row] * objectsInRow)) < objectsInRow) {
        int finishRange = [allSeparateProductsOfSubCat count] - ([indexPath row] * objectsInRow);
        tempArray = [allSeparateProductsOfSubCat subarrayWithRange:NSMakeRange(startRange, finishRange)];
    }
    else
    {
        tempArray = [allSeparateProductsOfSubCat subarrayWithRange:NSMakeRange(startRange, objectsInRow)];
    }
    
    REDCollectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCell"];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"REDCollectionCell" owner:self options:nil];
        cell = (REDCollectionCell *)[nib objectAtIndex:0];
        cell.delegate = self;
    }
    [cell setBackgroundColor:[UIColor clearColor]];
    [cell initObjectsWithRowCount:[indexPath row] objectInRow:[tempArray count]];
    [cell setData:tempArray rowCount:[indexPath row]];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

#pragma mark - REDCollectionVIew Delegate

- (void)openDishDetailView:(NSDictionary *)dishData
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(openDishDetailView:)]) {
            [self.delegate openDishDetailView:dishData];
        }
    }
}

@end