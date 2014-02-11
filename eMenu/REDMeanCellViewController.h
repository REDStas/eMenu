//
//  REDMeanCellViewController.h
//  eMenu
//
//  Created by Станислав Редреев on 12.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "REDOrder.h"

@protocol REDMeanObjectDelegate <NSObject>

- (void)openDishDetailView:(NSDictionary *)dishData;

@end

@interface REDMeanCellViewController : UIViewController
{
 
}

@property(strong, nonatomic) id <REDMeanObjectDelegate> delegate;
@property(strong, nonatomic) IBOutlet UILabel *meanNameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *meanImage;
@property (strong, nonatomic) IBOutlet UIButton *meanPrice;
@property (strong, nonatomic) IBOutlet UIButton *orderButton;
// iPad Device
@property(strong, nonatomic) IBOutlet UILabel *meanNameLabel_iPad;
@property (strong, nonatomic) IBOutlet UIImageView *meanImage_iPad;
@property (strong, nonatomic) IBOutlet UIButton *meanPrice_iPad;
@property (strong, nonatomic) IBOutlet UIButton *orderButton_iPad;
@property(nonatomic) int objectTag;
@property(strong, nonatomic) NSDictionary *productInfo;

- (IBAction)createOrderButtonPress:(id)sender;
- (IBAction)imageButtonPress:(id)sender;
- (void)writeMeanNameLabel:(NSString *)meanName;

@end