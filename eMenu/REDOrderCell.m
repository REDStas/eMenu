//
//  REDOrderCell.m
//  eMenu
//
//  Created by Станислав Редреев on 30.05.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import "REDOrderCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation REDOrderCell
@synthesize dishNameLabel, dishPriceLabel, selectorNumberLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)setStyle
{
    [self.dishNameLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:13.0]];
    [self.dishPriceLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:13.0]];
    [dishPriceValuteLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:16.0]];
    [self.selectorNumberLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:17.0]];
    selectorNumberView.layer.borderWidth = 1.0;
    selectorNumberView.layer.borderColor = [UIColor colorWithRed:203.0/255 green:207.0/255 blue:211.0/255 alpha:1.0].CGColor;
    selectorNumberView.layer.cornerRadius = 5.0;
    selectorNumberView.layer.masksToBounds = YES;
}

#pragma  mark - IBActions

- (IBAction)deleteItemPress:(id)sender
{
    NSLog(@"sender %i", [sender tag]);
    [[REDOrder sharedIndicatorFiles] removeItem:[NSString stringWithFormat:@"%i", [sender tag]]];
}

- (IBAction)moreItem:(id)sender {
    [[REDOrder sharedIndicatorFiles] moreItem:[NSString stringWithFormat:@"%i", [sender tag]]];
}

- (IBAction)lessItem:(id)sender {
    [[REDOrder sharedIndicatorFiles] lessItem:[NSString stringWithFormat:@"%i", [sender tag]]];
}

@end