//
//  REDOrderCell_iPad.h
//  eMenu
//
//  Created by Станислав Редреев on 24.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDOrder.h"
#import <QuartzCore/QuartzCore.h>

@interface REDOrderCell_iPad : UITableViewCell
{
    IBOutlet UILabel *dishPriceValuteLabel;
    IBOutlet UIView *selectorNumberView;
}

@property(strong, nonatomic) IBOutlet UILabel *dishNameLabel;
@property(strong, nonatomic) IBOutlet UILabel *dishPriceLabel;
@property(strong, nonatomic) IBOutlet UILabel *selectorNumberLabel;
@property (strong, nonatomic) IBOutlet UIButton *deleteButton_iPad;
@property (strong, nonatomic) IBOutlet UIButton *lessItemButton_iPad;
@property (strong, nonatomic) IBOutlet UIButton *moreItemButton_iPad;

- (void)setStyle;
- (IBAction)deleteItem:(id)sender;
- (IBAction)moreItem:(id)sender;
- (IBAction)lessItem:(id)sender;

@end
