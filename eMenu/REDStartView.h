//
//  REDStartView.h
//  eMenu
//
//  Created by Станислав Редреев on 07.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDOrderView.h"
#import "REDMenuView.h"

#import "AFImageRequestOperation.h"
#import "ZBarSDK.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface REDStartView : UIViewController <ZBarReaderDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate>
{
    // Classes
    REDOrderView *orderView;
    REDMenuView *menuView;
    ZBarReaderViewController *reader;
    
    // iPhone Device
    IBOutlet UILabel *firstDialogLabel_iPhone;
    IBOutlet UILabel *secondDialogLabel_iPhone;
    IBOutlet UILabel *thirdDialogLabel_iPhone;
    IBOutlet UILabel *fourthDialogLabel_iPhone;
    IBOutlet UIButton *scanButton_iPhone;
    IBOutlet UIView *activityView_iPhone;
    
    // iPad Device
    IBOutlet UILabel *firstDialogLabel_iPad;
    IBOutlet UILabel *secondDialogLabel_iPad;
    IBOutlet UILabel *thirdDialogLabel_iPad;
    IBOutlet UILabel *fourthDialogLabel_iPad;
    IBOutlet UILabel *andLabel_iPad;
    IBOutlet UILabel *helpLabel_iPad;
    IBOutlet UIButton *scanButton_iPad;
    IBOutlet UITextField *greenTextField_iPad;
    IBOutlet UIView *activityView_iPad;
    
    // All Device
    IBOutlet UIImageView *activityBackgroundImage;
    
}

- (IBAction)scannButtonPress:(id)sender;

@end
