//
//  REDMeanCellViewController.m
//  eMenu
//
//  Created by Станислав Редреев on 12.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import "REDMeanCellViewController.h"

@interface REDMeanCellViewController ()

@end

@implementation REDMeanCellViewController
@synthesize delegate, meanNameLabel, productInfo;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.meanNameLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:10.0]];
//    NSArray *textColor = [[REDOrder sharedIndicatorFiles] color_text];
//    [self.meanNameLabel setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
//    [self.meanNameLabel_iPad setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
//    [self.meanNameLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Regular" size:14.0]];
//    [self.meanPrice.titleLabel setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
//    [self.meanPrice_iPad.titleLabel setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
//    [self.orderButton.titleLabel setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
//    [self.orderButton_iPad.titleLabel setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
}
- (void)viewWillAppear:(BOOL)animated
{
    NSArray *color_order = [[REDOrder sharedIndicatorFiles] color_order];
    NSArray *textColor = [[REDOrder sharedIndicatorFiles] color_text];
    [self.meanNameLabel setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [self.meanNameLabel_iPad setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [self.meanNameLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:10.0]];
    [self.meanNameLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Regular" size:14.0]];
    [self.meanPrice.titleLabel setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [self.meanPrice_iPad.titleLabel setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [self.orderButton setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.orderButton_iPad setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [self.orderButton setBackgroundColor:[UIColor colorWithRed:[[color_order objectAtIndex:0] floatValue]/255.0 green:[[color_order objectAtIndex:1] floatValue]/255.0 blue:[[color_order objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [self.orderButton_iPad setBackgroundColor:[UIColor colorWithRed:[[color_order objectAtIndex:0] floatValue]/255.0 green:[[color_order objectAtIndex:1] floatValue]/255.0 blue:[[color_order objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    
    self.orderButton.layer.cornerRadius = 4.0;
    self.orderButton.layer.masksToBounds = YES;
    self.orderButton_iPad.layer.cornerRadius = 4.0;
    self.orderButton_iPad.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {

    [self setMeanNameLabel:nil];
    [self setMeanImage:nil];
    [self setMeanPrice:nil];
    [self setMeanImage:nil];
    [self setMeanPrice:nil];
    [self setOrderButton:nil];
    [self setOrderButton_iPad:nil];
    [super viewDidUnload];
}
- (IBAction)createOrderButtonPress:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [[REDOrder sharedIndicatorFiles] addItem:self.productInfo];
    }
    else{
        [[REDOrder sharedIndicatorFiles] addItem:self.productInfo];
    }
}

- (IBAction)imageButtonPress:(id)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(openDishDetailView:)]) {
            [self.delegate openDishDetailView:self.productInfo];
        }
    }
}

- (void)writeMeanNameLabel:(NSString *)meanName
{
    meanNameLabel.text = meanName;
}
@end