//
//  REDOrderView.m
//  eMenu
//
//  Created by Станислав Редреев on 07.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import "REDOrderView.h"

#import "REDDishDetail.h"

@interface REDOrderView ()

@end

@implementation REDOrderView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTotalPriceValueAndReloadTable) name:@"change_order_price_and_count" object:nil];
    [self changeTotalPriceValueAndReloadTable];
    
    NSArray *tempButtonColor = [[REDOrder sharedIndicatorFiles] color_button];
    NSArray *textColor = [[REDOrder sharedIndicatorFiles] color_text];
      
    // iPhone Device
    [dishNameTableCaption_iPhone setFont:[UIFont fontWithName:@"Roboto-Medium" size:11.0]];
    [countTableCaption_iPhone setFont:[UIFont fontWithName:@"Roboto-Medium" size:11.0]];
    [priceTableCaption_iPhone setFont:[UIFont fontWithName:@"Roboto-Medium" size:11.0]];
    [deleteTableCaption_iPhone setFont:[UIFont fontWithName:@"Roboto-Medium" size:11.0]];
    [captionTitleLabel_iPhone setFont:[UIFont fontWithName:@"Roboto-Regular" size:17.0]];
    //[captionView setBackgroundColor:[UIColor colorWithRed:[[tempBorderColor objectAtIndex:0] intValue]/255.0 green:[[tempBorderColor objectAtIndex:1] intValue]/255.0 blue:[[tempBorderColor objectAtIndex:2] intValue]/255.0 alpha:1.0]];
    [helpHeaderLabel_iPhone setText:@"    Чтобы удалить смахните вправо"];
    [helpHeaderLabel_iPhone setFont:[UIFont fontWithName:@"Roboto-Medium" size:10.0]];
    
    // style
    [orderButton_iPhone setBackgroundColor:[UIColor colorWithRed:[[tempButtonColor objectAtIndex:0] floatValue]/255.0 green:[[tempButtonColor objectAtIndex:1] floatValue]/255.0 blue:[[tempButtonColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [orderButton_iPhone setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
    orderButton_iPhone.layer.cornerRadius = 4.0;
    orderButton_iPhone.layer.masksToBounds = YES;
    // style
    [clearOrderButton_iPhone setBackgroundColor:[UIColor colorWithRed:[[tempButtonColor objectAtIndex:0] floatValue]/255.0 green:[[tempButtonColor objectAtIndex:1] floatValue]/255.0 blue:[[tempButtonColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [clearOrderButton_iPhone setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
    clearOrderButton_iPhone.layer.cornerRadius = 4.0;
    clearOrderButton_iPhone.layer.masksToBounds = YES;
    
    // iPad Device
    [dishNameTableCaption_iPad setFont:[UIFont fontWithName:@"Roboto-Medium" size:13.0]];
    [countTableCaption_iPad setFont:[UIFont fontWithName:@"Roboto-Medium" size:13.0]];
    [priceTableCaption_iPad setFont:[UIFont fontWithName:@"Roboto-Medium" size:13.0]];
    [deleteTableCaption_iPad setFont:[UIFont fontWithName:@"Roboto-Medium" size:13.0]];
    [captionTitleLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Regular" size:27.0]];
    
    // style
    [createOrderButton_iPad setBackgroundColor:[UIColor colorWithRed:[[tempButtonColor objectAtIndex:0] floatValue]/255.0 green:[[tempButtonColor objectAtIndex:1] floatValue]/255.0 blue:[[tempButtonColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [createOrderButton_iPad setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
    createOrderButton_iPad.layer.cornerRadius = 4.0;
    createOrderButton_iPad.layer.masksToBounds = YES;
    // style
    [clearOrderButton_iPad setBackgroundColor:[UIColor colorWithRed:[[tempButtonColor objectAtIndex:0] floatValue]/255.0 green:[[tempButtonColor objectAtIndex:1] floatValue]/255.0 blue:[[tempButtonColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [clearOrderButton_iPad setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
    clearOrderButton_iPad.layer.cornerRadius = 4.0;
    clearOrderButton_iPad.layer.masksToBounds = YES;
}

-(void)viewDidAppear:(BOOL)animated{
    [orderTableView_iPhone flashScrollIndicators];
    [orderTableView_iPad flashScrollIndicators];
    timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(indicator:) userInfo:nil repeats:YES];
}

-(void)viewDidDisappear:(BOOL)animated{
    [timer invalidate];
}

-(void)indicator:(BOOL)animated{
    [orderTableView_iPhone flashScrollIndicators];
    [orderTableView_iPad flashScrollIndicators];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    dishNameTableCaption_iPhone = nil;
    countTableCaption_iPhone = nil;
    priceTableCaption_iPhone = nil;
    deleteTableCaption_iPhone = nil;
    captionTitleLabel_iPhone = nil;
    totalPriceTitle_iPhone = nil;
    totalPriceNumber_iPhone = nil;
    totalPriceValutaLabel_iPhone = nil;
    orderTableView_iPhone = nil;
    orderTableView_iPad = nil;
    captionView = nil;
    helpHeaderLabel_iPhone = nil;
    orderButton_iPhone = nil;
    clearOrderButton_iPhone = nil;
    createOrderButton_iPad = nil;
    clearOrderButton_iPad = nil;
    [super viewDidUnload];
}

#pragma mark - TableView Delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        tableView.editing = YES;
        NSArray *productKeys = [[[REDOrder sharedIndicatorFiles] userOrder] allKeys];
        [[[REDOrder sharedIndicatorFiles] userOrder] removeObjectForKey:[productKeys objectAtIndex:[indexPath row]]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"change_order_price_and_count" object:nil];
        [tableView reloadData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[[REDOrder sharedIndicatorFiles] userOrder] allKeys] count];
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return 50;
    } else {
        return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *productKeys = [[NSMutableArray alloc] initWithArray:[[[REDOrder sharedIndicatorFiles] userOrder] allKeys]];
    
    if (tableView.tag == 88) {
        REDOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell"];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"REDOrderCell" owner:self options:nil];
            cell = (REDOrderCell *)[nib objectAtIndex:0];
        }
        
        [cell setStyle];
        NSMutableDictionary *tempProductsInfo = [[NSMutableDictionary alloc] init];
        tempProductsInfo = [[[REDOrder sharedIndicatorFiles] userOrder] objectForKey:[productKeys objectAtIndex:[indexPath row]]];
        //NSLog(@"%@", [tempProductsInfo description]);
        
        cell.dishNameLabel.text = [NSString stringWithFormat:@"%@", [tempProductsInfo objectForKey:@"mitemname"]];
        if ([tempProductsInfo objectForKey:@"priceXcount"]) {
            cell.dishPriceLabel.text = [NSString stringWithFormat:@"%@", [tempProductsInfo objectForKey:@"priceXcount"]];
        }
        else{
            cell.dishPriceLabel.text = [NSString stringWithFormat:@"%@", [tempProductsInfo objectForKey:@"price"]];
        }
                   cell.selectorNumberLabel.text = [NSString stringWithFormat:@"%@", [tempProductsInfo objectForKey:@"count"]];
        [cell.deleteButton_iPhone setTag:[(NSString *)[tempProductsInfo objectForKey:@"miid"] intValue]];
        [cell.moreButton_iPhone setTag:[(NSString *)[tempProductsInfo objectForKey:@"miid"] intValue]];
        [cell.lessButton_iPhone setTag:[(NSString *)[tempProductsInfo objectForKey:@"miid"] intValue]];
        
        return cell;
    }
    else if (tableView.tag == 69)
    {
        REDOrderCell_iPad *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderCell_iPad"];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"REDOrderCell_iPad" owner:self options:nil];
            cell = (REDOrderCell_iPad *)[nib objectAtIndex:0];
        }
        
        [cell setStyle];
        
        NSMutableDictionary *tempProductsInfo = [[NSMutableDictionary alloc] init];
        tempProductsInfo = [[[REDOrder sharedIndicatorFiles] userOrder] objectForKey:[productKeys objectAtIndex:[indexPath row]]];
        //NSLog(@"%@", [tempProductsInfo description]);
        
        cell.dishNameLabel.text = [NSString stringWithFormat:@"%@", [tempProductsInfo objectForKey:@"mitemname"]];
        if ([tempProductsInfo objectForKey:@"priceXcount"]) {
            cell.dishPriceLabel.text = [NSString stringWithFormat:@"%@", [tempProductsInfo objectForKey:@"priceXcount"]];
        }
        else{
            cell.dishPriceLabel.text = [NSString stringWithFormat:@"%@", [tempProductsInfo objectForKey:@"price"]];
        }
        
        cell.selectorNumberLabel.text = [NSString stringWithFormat:@"%@", [tempProductsInfo objectForKey:@"count"]];
        [cell.deleteButton_iPad setTag:[(NSString *)[tempProductsInfo objectForKey:@"miid"] intValue]];
        [cell.moreItemButton_iPad setTag:[(NSString *)[tempProductsInfo objectForKey:@"miid"] intValue]];
        [cell.lessItemButton_iPad setTag:[(NSString *)[tempProductsInfo objectForKey:@"miid"] intValue]];
        
        return cell;
    }
    else
    {
        return nil;
    }
}

#pragma mark - IBActions

- (IBAction)closeButtonPress:(id)sender
{
    [self.view removeFromSuperview];
}

- (IBAction)openDetailDishView:(id)sender {
    REDDishDetail *dishDetail = [[REDDishDetail alloc] initWithNibName:@"REDDishDetail_iPad" bundle:nil];
    [self presentModalViewController:dishDetail animated:YES];
}

- (IBAction)createOrderPress:(id)sender
{
    NSLog(@"userOrder%@", [[[REDOrder sharedIndicatorFiles] userOrder] description]);
    NSMutableArray *separateOrder = [[NSMutableArray alloc] init];
    NSDictionary *order = [[REDOrder sharedIndicatorFiles] userOrder];
    NSArray *productKeys = [order allKeys];
    for (int i = 0; i < [productKeys count]; i++) {
        NSDictionary *tempProduct = [order objectForKey:[productKeys objectAtIndex:i]];
//        NSMutableArray *tempSeparateProduct = [[NSMutableArray alloc] init];
//        [tempSeparateProduct addObject:[tempProduct objectForKey:@"miid"]];
//        [tempSeparateProduct addObject:[tempProduct objectForKey:@"count"]];
        NSNumber *miidNumber = [NSNumber numberWithInt:[[tempProduct objectForKey:@"miid"] integerValue]];
        NSNumber *countNumber = [NSNumber numberWithInt:[[tempProduct objectForKey:@"count"] integerValue]];
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:miidNumber, @"miid", countNumber, @"number", nil];
        [separateOrder addObject:dict];
    }
    NSLog(@"userOrder%@", [separateOrder description]);
    if ([separateOrder count] > 0) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:separateOrder options:NSJSONWritingPrettyPrinted error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonString %@", jsonString);
        NSString *totalPrice = @"0";
        NSDictionary *orderPriceAndCount = [[NSDictionary alloc] initWithDictionary:[[REDOrder sharedIndicatorFiles] getOrderPriceAndCount] copyItems:YES];
        totalPrice = [NSString stringWithFormat:@"%@", [orderPriceAndCount objectForKey:@"orderPrice"]];
                NSLog(@"%@", totalPrice);
        [[API sharedIndicatorFiles] setOrderWithUserVisitorID:[[REDOrder sharedIndicatorFiles] userID] table:[[REDOrder sharedIndicatorFiles] tableID] visitorAccessID:[[REDOrder sharedIndicatorFiles] vaID] mealsForOrder:jsonString summaryOrder:totalPrice success:^(id JSON) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Внимание!" message:@"Вы действительно хотите оформить ваш заказ?" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:@"Ок", nil];
            alertView.tag = 1;
            [alertView show];
        } error:^(id ERROR) {
            
        }];
    }
    else
    {
        UIAlertView *alertView2 = [[UIAlertView alloc] initWithTitle:@"Простите!" message:@"Ваш заказ пустой!" delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles:nil, nil];
        alertView2.tag = 2;
        [alertView2 show];
    }

}

- (IBAction)clearOrderPress:(id)sender
{
    [[REDOrder sharedIndicatorFiles] removeAllItems];
}

#pragma mark - Methods

- (void)changeTotalPriceValueAndReloadTable
{
    NSDictionary *orderPriceAndCount = [[NSDictionary alloc] initWithDictionary:[[REDOrder sharedIndicatorFiles] getOrderPriceAndCount] copyItems:YES];
    [totalPriceNumber_iPhone setText:[NSString stringWithFormat:@"%@грн.", [orderPriceAndCount objectForKey:@"orderPrice"]]];
    [totalPriceNumber_iPad setText:[NSString stringWithFormat:@"%@грн.", [orderPriceAndCount objectForKey:@"orderPrice"]]];
    [orderTableView_iPad reloadData];
    [orderTableView_iPhone reloadData];
}

#pragma mark - AlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1) {
        if (buttonIndex == 1) {
            [self.view removeFromSuperview];
            [[[REDOrder sharedIndicatorFiles] userOrder] removeAllObjects];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"change_order_price_and_count" object:nil];
        }
    }
}

@end