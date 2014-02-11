//
//  REDDishDetail.h
//  eMenu
//
//  Created by Станислав Редреев on 31.05.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>
#import "AFImageRequestOperation.h"
#import "REDOrder.h"

@interface REDDishDetail : UIViewController
{
    // iPhone Device
    IBOutlet UILabel *dishDetailCaptionLabel;    
    IBOutlet UIImageView *dishDetailImage;
    IBOutlet UILabel *dishDetaileInformationLabel;
    IBOutlet UILabel *dishDetailInformationCaptionLabel;
    IBOutlet UIScrollView *scrollViewDetail;
    IBOutlet UIButton *createOrderButton;
    IBOutlet UIView *weightAndPriceView;
    IBOutlet UILabel *weightLabel;
    IBOutlet UILabel *priceLabel;
    IBOutlet UILabel *slashLabel;
    
    // iPad Device
    IBOutlet UILabel *dishDetailCaptionLabel_iPad;
    IBOutlet UIImageView *dishDetailImage_iPad;
    IBOutlet UILabel *dishDetaileInformationLabel_iPad;
    IBOutlet UILabel *dishDetailInformationCaptionLabel_iPad;
    IBOutlet UIScrollView *scrollViewDetail_iPad;
    IBOutlet UIButton *createOrderButton_iPad;
    IBOutlet UIView *weightAndPriceView_iPad;
    IBOutlet UILabel *weightLabel_iPad;
    IBOutlet UILabel *priceLabel_iPad;
    
    // All Device
    IBOutlet UIView *captionView;
    NSTimer *timer;
}

@property(strong, nonatomic) IBOutlet UILabel *dishDetailCaptionLabel;
@property(strong, nonatomic) NSDictionary *productInfo;
@property (strong, nonatomic) IBOutlet UIView *informationView_iPhone;

- (IBAction)closeButtonPress:(id)sender;
- (void)setData:(NSDictionary *)data;
- (IBAction)addItemToOrder:(id)sender;

@end
