//
//  REDOrderCell.h
//  eMenu
//
//  Created by Станислав Редреев on 30.05.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "REDOrder.h"

@interface REDOrderCell : UITableViewCell
{
    IBOutlet UILabel *dishPriceValuteLabel;
    IBOutlet UIView *selectorNumberView;    
}

@property(strong, nonatomic) IBOutlet UILabel *dishNameLabel;
@property(strong, nonatomic) IBOutlet UILabel *dishPriceLabel;
@property(strong, nonatomic) IBOutlet UILabel *selectorNumberLabel;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton_iPhone;
@property (strong, nonatomic) IBOutlet UIButton *moreButton_iPhone;
@property (strong, nonatomic) IBOutlet UIButton *lessButton_iPhone;

- (void)setStyle;
- (IBAction)deleteItemPress:(id)sender;
- (IBAction)moreItem:(id)sender;
- (IBAction)lessItem:(id)sender;

@end
