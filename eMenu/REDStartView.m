//
//  REDStartView.m
//  eMenu
//
//  Created by Станислав Редреев on 07.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import "REDStartView.h"

@interface REDStartView ()

@end

@implementation REDStartView

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
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    
    // Classes
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        menuView = [[REDMenuView alloc] initWithNibName:@"REDMenuView_iPhone" bundle:nil];
    } else {
        menuView = [[REDMenuView alloc] initWithNibName:@"REDMenuView_iPad" bundle:nil];
    }
    
    // iPhone Device
    [scanButton_iPhone.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:18.0]];
    [firstDialogLabel_iPhone setFont:[UIFont fontWithName:@"Roboto-Thin" size:55.0]];
    [secondDialogLabel_iPhone setFont:[UIFont fontWithName:@"Roboto-Thin" size:27.0]];
    [thirdDialogLabel_iPhone setFont:[UIFont fontWithName:@"Roboto-Thin" size:24.0]];
    [fourthDialogLabel_iPhone setFont:[UIFont fontWithName:@"Roboto-BoldCondensed" size:37.0]];
    
    [scanButton_iPhone setTintColor:[UIColor greenColor]];
    
    // iPad Device
    [scanButton_iPad.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:25.0]];
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 20)];
    greenTextField_iPad.leftView = paddingView;
    greenTextField_iPad.leftViewMode = UITextFieldViewModeAlways;
    [greenTextField_iPad setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    [firstDialogLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Thin" size:72.0]];
    [secondDialogLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Thin" size:35.0]];
    [thirdDialogLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Thin" size:30.0]];
    [fourthDialogLabel_iPad setFont:[UIFont fontWithName:@"Roboto-BoldCondensed" size:45.0]];
    [andLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Medium" size:25.0]];
    [helpLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Regular" size:19.0]];
    
    // Date
    CFUUIDRef identifierObject = CFUUIDCreate(kCFAllocatorDefault);
    NSString *deviceID = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, identifierObject);

    [[API sharedIndicatorFiles] connectionWithEmail:@"test@gmail.com" appID:deviceID appType:@"ios" languageID:@"ru" success:^(id JSON) {
        NSString *userID = [NSString stringWithFormat:@"%@", [(NSDictionary *)[(NSDictionary *)[JSON objectForKey:@"data"] objectForKey:@"0"] objectForKey:@"uvid"]];
        NSString *userLanguage = [NSString stringWithFormat:@"%@", [(NSDictionary *)[(NSDictionary *)[JSON objectForKey:@"data"] objectForKey:@"0"] objectForKey:@"lid"]];
        [[REDOrder sharedIndicatorFiles] setUserID:userID];
        [[REDOrder sharedIndicatorFiles] setUserLanguage:userLanguage];
    } error:^(id ERROR) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка!" message:@"Отсутствует связь с сервером!" delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles:nil, nil];
        [alertView show];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [scanButton_iPhone setTintColor:[UIColor greenColor]];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    scanButton_iPhone = nil;
    firstDialogLabel_iPhone = nil;
    secondDialogLabel_iPhone = nil;
    thirdDialogLabel_iPhone = nil;
    fourthDialogLabel_iPhone = nil;
    firstDialogLabel_iPad = nil;
    secondDialogLabel_iPad = nil;
    thirdDialogLabel_iPad = nil;
    fourthDialogLabel_iPad = nil;
    andLabel_iPad = nil;
    helpLabel_iPad = nil;
    scanButton_iPad = nil;
    greenTextField_iPad = nil;
    activityView_iPhone = nil;
    activityView_iPad = nil;
    activityBackgroundImage = nil;
    [super viewDidUnload];
}

#pragma mark - Orientation

- (IBAction)scannButtonPress:(id)sender
{
    reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    ZBarImageScanner *scanner = reader.scanner;
    reader.tracksSymbols = YES;

    [scanner setSymbology:0 config:ZBAR_CFG_ENABLE to:0];
    [scanner setSymbology:ZBAR_QRCODE config:ZBAR_CFG_ENABLE to:1];
    
    reader.readerView.zoom = 1.0;
    [[[reader.view subviews] objectAtIndex:1] setHidden:YES];

    // Set Style
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIView *caption = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [caption setBackgroundColor:[UIColor colorWithRed:68.0/255 green:77.0/255 blue:90.0/255 alpha:1.0]];
        UILabel *captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
        [captionLabel setBackgroundColor:[UIColor clearColor]];
        [captionLabel setText:@"Наведите на QR Code"];
        [captionLabel setTextAlignment:NSTextAlignmentCenter];
        [captionLabel setTextColor:[UIColor colorWithRed:225.0/255 green:232.0/255 blue:240.0/255 alpha:1.0]];
        [captionLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:16.0]];
        [caption addSubview:captionLabel];
        UIView *topGreenLine = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 6)];
        [topGreenLine setBackgroundColor:[UIColor colorWithRed:75.0/255 green:135.0/255 blue:42.0/255 alpha:1.0]];
        UIView *leftGreenLine = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 6, 450)];
        [leftGreenLine setBackgroundColor:[UIColor colorWithRed:75.0/255 green:135.0/255 blue:42.0/255 alpha:1.0]];
        UIView *rightGreenLine = [[UIView alloc] initWithFrame:CGRectMake(314, 40, 6, 450)];
        [rightGreenLine setBackgroundColor:[UIColor colorWithRed:75.0/255 green:135.0/255 blue:42.0/255 alpha:1.0]];
        UIView *bottomHelpGreenLine = [[UIView alloc] initWithFrame:CGRectMake(0, 250, 320, 55)];
        if ([[UIScreen mainScreen] bounds].size.height == 480) {
            [bottomHelpGreenLine setFrame:CGRectMake(0, 375, 320, 56)];
        }
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            [bottomHelpGreenLine setFrame:CGRectMake(0, 463, 320, 56)];
        }
        [bottomHelpGreenLine setBackgroundColor:[UIColor colorWithRed:75.0/255 green:135.0/255 blue:42.0/255 alpha:1.0]];
        UILabel *helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 7, 310, 20)];
        [helpLabel setText:@"Подсказка:"];
        [helpLabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:13.0]];
        [helpLabel setTextColor:[UIColor whiteColor]];
        [helpLabel setBackgroundColor:[UIColor clearColor]];
        UILabel *helpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 20, 310, 35)];
        [helpLabel2 setText:@"Удерживайте телефон неподвижно примерно в 20см."];
        [helpLabel2 setFont:[UIFont fontWithName:@"Roboto-Regular" size:12.0]];
        [helpLabel2 setTextColor:[UIColor whiteColor]];
        [helpLabel2 setBackgroundColor:[UIColor clearColor]];
        
        [bottomHelpGreenLine addSubview:helpLabel];
        [bottomHelpGreenLine addSubview:helpLabel2];
        
        UIView *bottomPanel = [[UIView alloc] init];
        if ([[UIScreen mainScreen] bounds].size.height == 480) {
            [bottomPanel setFrame:CGRectMake(0, 431, 320, 49)];
        }
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            [bottomPanel setFrame:CGRectMake(0, 519, 320, 55)];
        }
        UIImageView *backgroundImageOfBottomPanel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomPanelBackground"]];
        [backgroundImageOfBottomPanel setFrame:CGRectMake(0, 0, 320, 49)];
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(7, 12, 151, 30)];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"qrScannerCancelButton"] forState:UIControlStateNormal];
        [cancelButton setTitle:@"ОТМЕНА" forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(cloceQRScanner) forControlEvents:UIControlEventTouchUpInside];
        //[cancelButton addTarget:nil action:[[[[[[[reader.view subviews] objectAtIndex:1] subviews] objectAtIndex:0] subviews] objectAtIndex:2] action] forControlEvents:UIControlEventTouchUpInside];
        
        [bottomPanel addSubview:backgroundImageOfBottomPanel];
        [bottomPanel addSubview:cancelButton];
        
        [reader.view addSubview:caption];
        [reader.view addSubview:topGreenLine];
        [reader.view addSubview:leftGreenLine];
        [reader.view addSubview:rightGreenLine];
        [reader.view addSubview:bottomHelpGreenLine];
        [reader.view addSubview:bottomPanel];
    }
    else
    {
        UIView *caption = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 64)];
        //[caption setBackgroundColor:[UIColor colorWithRed:68.0/255 green:77.0/255 blue:90.0/255 alpha:1.0]];
        [caption setBackgroundColor:[UIColor colorWithRed:75.0/255 green:135.0/255 blue:42.0/255 alpha:1.0]];
        UILabel *captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1024, 64)];
        [captionLabel setBackgroundColor:[UIColor clearColor]];
        [captionLabel setText:@"Наведите на QR Code"];
        [captionLabel setTextAlignment:NSTextAlignmentCenter];
        [captionLabel setTextColor:[UIColor colorWithRed:225.0/255 green:232.0/255 blue:240.0/255 alpha:1.0]];
        [captionLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:27.0]];
        [caption addSubview:captionLabel];
        //UIView *topGreenLine = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 320, 6)];
        //[topGreenLine setBackgroundColor:[UIColor colorWithRed:75.0/255 green:135.0/255 blue:42.0/255 alpha:1.0]];
        UIView *leftGreenLine = [[UIView alloc] initWithFrame:CGRectMake(0, 40, 17, 900)];
        [leftGreenLine setBackgroundColor:[UIColor colorWithRed:75.0/255 green:135.0/255 blue:42.0/255 alpha:1.0]];
        UIView *rightGreenLine = [[UIView alloc] initWithFrame:CGRectMake(1007, 40, 17, 900)];
        [rightGreenLine setBackgroundColor:[UIColor colorWithRed:75.0/255 green:135.0/255 blue:42.0/255 alpha:1.0]];
        UIView *bottomHelpGreenLine = [[UIView alloc] initWithFrame:CGRectMake(0, 655, 1024, 400)];
        [bottomHelpGreenLine setBackgroundColor:[UIColor colorWithRed:75.0/255 green:135.0/255 blue:42.0/255 alpha:1.0]];
        UILabel *helpLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 26, 1024, 20)];
        [helpLabel setText:@"Подсказка:"];
        [helpLabel setFont:[UIFont fontWithName:@"Roboto-Bold" size:22.0]];
        [helpLabel setTextColor:[UIColor whiteColor]];
        [helpLabel setBackgroundColor:[UIColor clearColor]];
        UILabel *helpLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(22, 46, 1024, 35)];
        [helpLabel2 setText:@"Удерживайте телефон неподвижно примерно в 20см."];
        [helpLabel2 setFont:[UIFont fontWithName:@"Roboto-Regular" size:20.0]];
        [helpLabel2 setTextColor:[UIColor whiteColor]];
        [helpLabel2 setBackgroundColor:[UIColor clearColor]];
        
        [bottomHelpGreenLine addSubview:helpLabel];
        [bottomHelpGreenLine addSubview:helpLabel2];
        
        UIView *bottomPanel = [[UIView alloc] init];
        [bottomPanel setFrame:CGRectMake(0, 655, 1024, 400)];
        UIImageView *backgroundImageOfBottomPanel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bottomPanelBackground"]];
        [backgroundImageOfBottomPanel setFrame:CGRectMake(0, 0, 320, 49)];
        UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(757, 32, 250, 50)];
        [cancelButton setBackgroundImage:[UIImage imageNamed:@"QRScannerButton_iPad"] forState:UIControlStateNormal];
        [cancelButton setTitle:@"ОТМЕНА" forState:UIControlStateNormal];
        [cancelButton.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:20.0]];
        [cancelButton addTarget:self action:@selector(cloceQRScanner) forControlEvents:UIControlEventTouchUpInside];
        
        [bottomPanel addSubview:cancelButton];
        [reader.view addSubview:caption];
        [reader.view addSubview:leftGreenLine];
        [reader.view addSubview:rightGreenLine];
        [reader.view addSubview:bottomHelpGreenLine];
        [reader.view setFrame:CGRectMake(0, 0, 1024, 768)];
        [reader.view addSubview:bottomPanel];
    }
    [self.view addSubview:reader.view];
}

#pragma mark - ZBar Scanner Delegate

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    id<NSFastEnumeration> results = [info objectForKey:ZBarReaderControllerResults];

    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    NSArray *QRCodeValues = [[NSString stringWithFormat:@"%@", symbol.data] componentsSeparatedByString:@"."];
    if ([QRCodeValues count] == 3) {
        [[API sharedIndicatorFiles] clientThemeWithID:@"1" success:^(id JSON) {
            NSLog(@"%@", JSON);
            [[REDOrder sharedIndicatorFiles] setClientStyle:[JSON objectForKey:@"data"]];
            
            NSString *imageURL = [NSString stringWithFormat:@"http://emenu.uran.in.ua/%@", [[JSON objectForKey:@"data"] objectForKey:@"home_screen"]];
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
            AFImageRequestOperation *operation;
            operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                         {
                             [activityBackgroundImage setImage:image];
                         }
                                                                          failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                                              NSLog(@"46226%@", error);
                                                                          }];
            [operation start];
            
            [activityView_iPhone setHidden:NO];
            [activityView_iPad setHidden:NO];
            [[API sharedIndicatorFiles] tableVisitWithUserVisitorID:[[REDOrder sharedIndicatorFiles] userID] filial:[QRCodeValues objectAtIndex:1] table:[QRCodeValues objectAtIndex:2] language:[[REDOrder sharedIndicatorFiles] userLanguage] menu:[QRCodeValues objectAtIndex:1] success:^(id JSON) {
                NSLog(@"%@", [JSON description]);
                [[REDOrder sharedIndicatorFiles] setMenuData:[JSON objectForKey:@"data"]];
                [[REDOrder sharedIndicatorFiles] setTableID:[NSString stringWithFormat:@"%@", [QRCodeValues objectAtIndex:2]]];
                [[REDOrder sharedIndicatorFiles] setResourceData:[JSON objectForKey:@"data"]];
                [[REDOrder sharedIndicatorFiles] separateDataForCategories:[JSON objectForKey:@"data"]];
                
                [[REDOrder sharedIndicatorFiles] setVaID:[JSON objectForKey:@"vaid"]];
                [activityView_iPhone setHidden:YES];
                [activityView_iPad setHidden:YES];
                [self presentModalViewController:menuView animated:YES];
            }
                                                              error:^(id ERROR) {
                                                                  UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка!" message:@"Отсутствует связь с сервером!" delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles:nil, nil];
                                                                  [alertView show];
                                                                  [activityView_iPhone setHidden:YES];
                                                                  [activityView_iPad setHidden:YES];
                                                              }];
            
        } error:^(id ERROR) {
            
        }];
        [picker.view removeFromSuperview];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка!" message:@"Отсканированый QR код неверен, попробуйте отсканировать другой QR код!" delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles:nil, nil];
        [alertView show];
        [activityView_iPhone setHidden:YES];
        [activityView_iPad setHidden:YES];
        [picker.view removeFromSuperview];
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    }
}

#pragma  mark - UITextField

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeRight)
    {
        [UIView
         animateWithDuration:0.25
         animations:^{
             self.view.frame = CGRectMake(-352, 0, self.view.frame.size.width, self.view.frame.size.height);
         }];
    }
    if([[UIDevice currentDevice] orientation] == UIDeviceOrientationLandscapeLeft)
    {
        [UIView
         animateWithDuration:0.25
         animations:^{
             self.view.frame = CGRectMake(352, 0, self.view.frame.size.width, self.view.frame.size.height);
         }];
    }
}

//- (void)textFieldDidEndEditing:(UITextField *)textField
//{
//    [UIView
//     animateWithDuration:0.25
//     animations:^{
//         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//     }];
//    
//    NSArray *answerData = [[NSString stringWithFormat:@"%@", textField.text] componentsSeparatedByString:@"."];
//    if ([answerData count] == 3) {
//        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//        [activityView_iPhone setHidden:NO];
//        [activityView_iPad setHidden:NO];
//        [[API sharedIndicatorFiles] tableVisitWithUserVisitorID:[[REDOrder sharedIndicatorFiles] userID] filial:[answerData objectAtIndex:1] table:[answerData objectAtIndex:2] language:[[REDOrder sharedIndicatorFiles] userLanguage] menu:@"1" success:^(id JSON) {
//            NSLog(@"%@", [JSON description]);
//            [[REDOrder sharedIndicatorFiles] setMenuData:[JSON objectForKey:@"data"]];
//            [[REDOrder sharedIndicatorFiles] setTableID:[NSString stringWithFormat:@"%@", [answerData objectAtIndex:2]]];
//            [[REDOrder sharedIndicatorFiles] setResourceData:[JSON objectForKey:@"data"]];
//            [[REDOrder sharedIndicatorFiles] separateDataForCategories:[JSON objectForKey:@"data"]];
//            [activityView_iPhone setHidden:YES];
//            [activityView_iPad setHidden:YES];
//            [self presentModalViewController:menuView animated:YES];
//        }
//                                                          error:^(id ERROR) {
//                                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка!" message:@"Отсутствует связь с сервером!" delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles:nil, nil];
//                                                              [alertView show];
//                                                              [activityView_iPhone setHidden:YES];
//                                                              [activityView_iPad setHidden:YES];
//                                                          }];
//        [[API sharedIndicatorFiles] clientThemeWithID:@"1" success:^(id JSON) {
//            [[REDOrder sharedIndicatorFiles] setClientStyle:[JSON objectForKey:@"data"]];
//        } error:^(id ERROR) {
//            
//        }];
//    }
//    
//
//}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [UIView
     animateWithDuration:0.25
     animations:^{
         self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
     }];
 
    NSArray *answerData = [[NSString stringWithFormat:@"%@", textField.text] componentsSeparatedByString:@"."];
    if ([answerData count] == 3) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
        [activityView_iPhone setHidden:NO];
        [activityView_iPad setHidden:NO];
        [[API sharedIndicatorFiles] tableVisitWithUserVisitorID:[[REDOrder sharedIndicatorFiles] userID] filial:[answerData objectAtIndex:1] table:[answerData objectAtIndex:2] language:[[REDOrder sharedIndicatorFiles] userLanguage] menu:@"1" success:^(id JSON)
        {
            [[REDOrder sharedIndicatorFiles] setMenuData:[JSON objectForKey:@"data"]];
            NSLog(@"vaid %@", [JSON objectForKey:@"vaid"]);
            [[REDOrder sharedIndicatorFiles] setVaID:[JSON objectForKey:@"vaid"]];
            [[REDOrder sharedIndicatorFiles] setTableID:[NSString stringWithFormat:@"%@", [answerData objectAtIndex:2]]];
            [[REDOrder sharedIndicatorFiles] setResourceData:[JSON objectForKey:@"data"]];
            [[REDOrder sharedIndicatorFiles] separateDataForCategories:[JSON objectForKey:@"data"]];
            [activityView_iPhone setHidden:YES];
            [activityView_iPad setHidden:YES];
            [self presentModalViewController:menuView animated:YES];
        }
        error:^(id ERROR) {
              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Ошибка!" message:@"Отсутствует связь с сервером!" delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles:nil, nil];
              [alertView show];
              [activityView_iPhone setHidden:YES];
              [activityView_iPad setHidden:YES];
          }];
        [[API sharedIndicatorFiles] clientThemeWithID:@"1" success:^(id JSON) {
            [[REDOrder sharedIndicatorFiles] setClientStyle:[JSON objectForKey:@"data"]];
        }
        error:^(id ERROR) {
            
        }];
    }

    
    return NO;
}

- (void)cloceQRScanner
{
    [reader.view removeFromSuperview];
}

@end
