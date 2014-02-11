//
//  REDDishDetail.m
//  eMenu
//
//  Created by Станислав Редреев on 31.05.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import "REDDishDetail.h"

@interface REDDishDetail ()

@end

@implementation REDDishDetail

@synthesize dishDetailCaptionLabel, productInfo;

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
    NSArray *tempButtonColor = [[REDOrder sharedIndicatorFiles] color_button];
    NSArray *textColor = [[REDOrder sharedIndicatorFiles] color_text];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //[dishDetailCaptionLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:17.0]];
        [dishDetaileInformationLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:13.0]];
        [dishDetailInformationCaptionLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:13.0]];
        [priceLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:21.0]];
        [weightLabel setFont:[UIFont fontWithName:@"Roboto-Regular" size:14.0]];
        //style
        [createOrderButton setBackgroundColor:[UIColor colorWithRed:[[tempButtonColor objectAtIndex:0] floatValue]/255.0 green:[[tempButtonColor objectAtIndex:1] floatValue]/255.0 blue:[[tempButtonColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
        [createOrderButton setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
        createOrderButton.layer.cornerRadius = 4.0;
        createOrderButton.layer.masksToBounds = YES;
        dishDetaileInformationLabel.text = [NSString stringWithFormat:@"                             %@", dishDetaileInformationLabel.text];
        CGSize dishDetaileInformationLabelTextSize = [dishDetaileInformationLabel.text sizeWithFont:dishDetaileInformationLabel.font constrainedToSize:CGSizeMake(dishDetaileInformationLabel.frame.size.width, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        
        [dishDetaileInformationLabel setFrame:CGRectMake(dishDetaileInformationLabel.frame.origin.x, dishDetaileInformationLabel.frame.origin.y, dishDetaileInformationLabel.frame.size.width, dishDetaileInformationLabelTextSize.height)];
        [scrollViewDetail setContentSize:CGSizeMake(scrollViewDetail.frame.size.width, dishDetaileInformationLabel.frame.size.height /*+ weightAndPriceView.frame.size.height + 20 + 20 + 20 + 20 + 31*/ + 20)];
    }
    else
    {
        [dishDetaileInformationLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Regular" size:16.0]];
        [dishDetailInformationCaptionLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Medium" size:16.0]];
        [priceLabel_iPad setMinimumFontSize:18.0];
        [priceLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Medium" size:18.0]];
        [weightLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Medium" size:14.0]];
        dishDetaileInformationLabel_iPad.text = [NSString stringWithFormat:@"                             %@", dishDetaileInformationLabel_iPad.text];
        [createOrderButton_iPad.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:16.0]];
        [createOrderButton_iPad setBackgroundColor:[UIColor colorWithRed:[[tempButtonColor objectAtIndex:0] floatValue]/255.0 green:[[tempButtonColor objectAtIndex:1] floatValue]/255.0 blue:[[tempButtonColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
        [createOrderButton_iPad setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
        createOrderButton_iPad.layer.cornerRadius = 4.0;
        createOrderButton_iPad.layer.masksToBounds = YES;
        
        CGSize dishDetaileInformationLabelTextSize = [dishDetaileInformationLabel_iPad.text sizeWithFont:dishDetaileInformationLabel_iPad.font constrainedToSize:CGSizeMake(dishDetaileInformationLabel_iPad.frame.size.width, 10000) lineBreakMode:NSLineBreakByWordWrapping];
        
        [dishDetaileInformationLabel_iPad setFrame:CGRectMake(dishDetaileInformationLabel_iPad.frame.origin.x, dishDetaileInformationLabel_iPad.frame.origin.y, dishDetaileInformationLabel_iPad.frame.size.width, dishDetaileInformationLabelTextSize.height)];
        [scrollViewDetail_iPad setContentSize:CGSizeMake(scrollViewDetail_iPad.frame.size.width, dishDetaileInformationLabel_iPad.frame.size.height)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    dishDetailCaptionLabel = nil;
    dishDetaileInformationLabel = nil;
    dishDetailInformationCaptionLabel = nil;
    scrollViewDetail = nil;
    createOrderButton = nil;
    weightAndPriceView = nil;
    weightLabel = nil;
    priceLabel = nil;
    dishDetailImage = nil;
    dishDetailImage_iPad = nil;
    [self setInformationView_iPhone:nil];
    slashLabel = nil;
    captionView = nil;
    [super viewDidUnload];
}

#pragma mark - Methods

- (void)setData:(NSDictionary *)data
{
    NSLog(@"dish data - %@", data);
    // iPhone
    [dishDetailCaptionLabel setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"mitemname"]]];
    [dishDetaileInformationLabel setText:[NSString stringWithFormat:@"                             %@", [data objectForKey:@"description"]]];
    CGFloat weightFloat = [[data objectForKey:@"weight"] floatValue];
    [weightLabel setText:[NSString stringWithFormat:@"%iгр.", (int)weightFloat]];
    [priceLabel setText:[NSString stringWithFormat:@"%@грн.", [data objectForKey:@"price"]]];
    
    CGSize dishDetaileInformationLabelTextSize = [dishDetaileInformationLabel.text sizeWithFont:dishDetaileInformationLabel.font constrainedToSize:CGSizeMake(dishDetaileInformationLabel.frame.size.width, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    [dishDetaileInformationLabel setFrame:CGRectMake(dishDetaileInformationLabel.frame.origin.x, dishDetaileInformationLabel.frame.origin.y, dishDetaileInformationLabel.frame.size.width, dishDetaileInformationLabelTextSize.height)];
    [scrollViewDetail setContentSize:CGSizeMake(scrollViewDetail.frame.size.width, dishDetaileInformationLabel.frame.size.height /*+ weightAndPriceView.frame.size.height + 20 + 20 + 20 + 20 + 31*/ + 20)];
    
    CGSize weightLabelTextSize = [weightLabel.text sizeWithFont:weightLabel.font constrainedToSize:CGSizeMake(weightLabel.frame.size.width, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    CGSize priceLabelTextSize = [priceLabel.text sizeWithFont:priceLabel.font constrainedToSize:CGSizeMake(priceLabel.frame.size.width, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat allTextSize = weightLabelTextSize.width + priceLabelTextSize.width + 10.0 + 10.0;
    CGFloat textPaddingLeft = (226 - allTextSize) / 2;
    [weightLabel setFrame:CGRectMake(textPaddingLeft, weightLabel.frame.origin.y, weightLabelTextSize.width, weightLabel.frame.size.height)];
    [slashLabel setFrame:CGRectMake(weightLabel.frame.origin.x + weightLabelTextSize.width + 5, slashLabel.frame.origin.y, 10, slashLabel.frame.size.height)];
    [priceLabel setFrame:CGRectMake(slashLabel.frame.origin.x + 5 + 10, priceLabel.frame.origin.y, priceLabelTextSize.width, priceLabel.frame.size.height)];
    
    // iPad
    [dishDetailCaptionLabel_iPad setText:[NSString stringWithFormat:@"%@", [data objectForKey:@"mitemname"]]];
    [dishDetaileInformationLabel_iPad setText:[NSString stringWithFormat:@"                             %@", [data objectForKey:@"description"]]];
    CGFloat weightFloat_iPad = [[data objectForKey:@"weight"] floatValue];
    [weightLabel_iPad setText:[NSString stringWithFormat:@"%iгр.", (int)weightFloat_iPad]];
    [priceLabel_iPad setText:[NSString stringWithFormat:@"%@грн.", [data objectForKey:@"price"]]];
    
    CGSize dishDetaileInformationLabelTextSize2 = [dishDetaileInformationLabel_iPad.text sizeWithFont:dishDetaileInformationLabel_iPad.font constrainedToSize:CGSizeMake(dishDetaileInformationLabel_iPad.frame.size.width, 10000) lineBreakMode:NSLineBreakByWordWrapping];
    [dishDetaileInformationLabel_iPad setFrame:CGRectMake(dishDetaileInformationLabel_iPad.frame.origin.x, dishDetaileInformationLabel_iPad.frame.origin.y, dishDetaileInformationLabel_iPad.frame.size.width, dishDetaileInformationLabelTextSize2.height)];
    [scrollViewDetail_iPad setContentSize:CGSizeMake(scrollViewDetail_iPad.frame.size.width, dishDetaileInformationLabel_iPad.frame.size.height)];
    
    NSString *imageURL = [NSString stringWithFormat:@"http://emenu.uran.in.ua/%@", [data objectForKey:@"image_l"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    AFImageRequestOperation *operation;
    operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
    {
        [dishDetailImage setImage:image];
        [dishDetailImage_iPad setImage:image];
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"46226%@", error);
    }];
    [operation start];
}

- (IBAction)addItemToOrder:(id)sender
{
    [[REDOrder sharedIndicatorFiles] addItem:self.productInfo];
    NSString *alertViewMessage = [NSString stringWithFormat:@"Вы добавили \"%@\" в свой заказ!", [self.productInfo objectForKey:@"mitemname"]];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Поздравляем!" message:alertViewMessage delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma  mark - IBActions

- (IBAction)closeButtonPress:(id)sender
{
    [self.view removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated{
    [scrollViewDetail flashScrollIndicators];
    [scrollViewDetail_iPad flashScrollIndicators];
    timer = [NSTimer scheduledTimerWithTimeInterval:4 target:self selector:@selector(indicator:) userInfo:nil repeats:YES];
    
    if ([dishDetaileInformationLabel.text length] == 29) {
        dishDetailInformationCaptionLabel.text = @"";
    }
    else
    {
        dishDetailInformationCaptionLabel.text = @"Ингридиенты:";
    }
    
    if ([dishDetaileInformationLabel_iPad.text isEqual:@"                             "]) {
        dishDetailInformationCaptionLabel_iPad.text = @"";
    }
    else
    {
        dishDetailInformationCaptionLabel_iPad.text = @"Ингридиенты:";
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [timer invalidate];
}

-(void)indicator:(BOOL)animated{
    [scrollViewDetail flashScrollIndicators];
    [scrollViewDetail_iPad flashScrollIndicators];
}

@end