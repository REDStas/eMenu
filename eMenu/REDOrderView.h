//
//  REDOrderView.h
//  eMenu
//
//  Created by Станислав Редреев on 07.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDOrderCell.h"
#import "REDOrderCell_iPad.h"
#import "API.h"

@interface REDOrderView : UIViewController <UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate>
{
    // iPhone Device
    IBOutlet UILabel *dishNameTableCaption_iPhone;
    IBOutlet UILabel *countTableCaption_iPhone;
    IBOutlet UILabel *priceTableCaption_iPhone;
    IBOutlet UILabel *deleteTableCaption_iPhone;
    IBOutlet UILabel *captionTitleLabel_iPhone;
    IBOutlet UILabel *totalPriceTitle_iPhone;
    IBOutlet UILabel *totalPriceNumber_iPhone;
    IBOutlet UILabel *totalPriceValutaLabel_iPhone;
    IBOutlet UITableView *orderTableView_iPhone;
    IBOutlet UILabel *helpHeaderLabel_iPhone;
    IBOutlet UIButton *orderButton_iPhone;
    IBOutlet UIButton *clearOrderButton_iPhone;
    
    // iPad Device
    IBOutlet UILabel *dishNameTableCaption_iPad;
    IBOutlet UILabel *countTableCaption_iPad;
    IBOutlet UILabel *priceTableCaption_iPad;
    IBOutlet UILabel *deleteTableCaption_iPad;
    IBOutlet UILabel *captionTitleLabel_iPad;
    IBOutlet UILabel *totalPriceTitle_iPad;
    IBOutlet UILabel *totalPriceNumber_iPad;
    IBOutlet UILabel *totalPriceValutaLabel_iPad;
    IBOutlet UITableView *orderTableView_iPad;
    IBOutlet UIButton *createOrderButton_iPad;
    IBOutlet UIButton *clearOrderButton_iPad;
    
    // All Device
    IBOutlet UIView *captionView;
    NSTimer *timer;
}

- (IBAction)closeButtonPress:(id)sender;
- (IBAction)openDetailDishView:(id)sender;
- (IBAction)createOrderPress:(id)sender;
- (IBAction)clearOrderPress:(id)sender;

@end
