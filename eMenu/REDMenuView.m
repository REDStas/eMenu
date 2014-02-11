//
//  REDMenuView.m
//  eMenu
//
//  Created by Станислав Редреев on 10.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import "REDMenuView.h"

@interface REDMenuView ()

@end

@implementation REDMenuView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOrderPriceCount) name:@"change_order_price_and_count" object:nil];
    [self changeOrderPriceCount];

    meansData = [[NSMutableDictionary alloc] initWithDictionary:[[REDOrder sharedIndicatorFiles] resourceData]];
    allProduct = [[NSMutableDictionary alloc] init];
    allProduct = [[self separateResourceData:meansData categoryID:@"0"] copy];
    categories = [[[REDOrder sharedIndicatorFiles] categories] copy];

    
    // iPhone Device
    isMenuViewOpen_iPhone = NO;
    [basketLabel_iPhone setFont:[UIFont fontWithName:@"Roboto-Medium" size:13.0]];
    [totalPriceLabel_iPhone setFont:[UIFont fontWithName:@"Roboto-Medium" size:13.0]];
    [[callWaiterButton_iPhone titleLabel] setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.0]];
    // style
    NSArray *tempButtonColor = [[REDOrder sharedIndicatorFiles] color_button];
    NSArray *textColor = [[REDOrder sharedIndicatorFiles] color_text];

    [callWaiterButton_iPhone setBackgroundColor:[UIColor colorWithRed:[[tempButtonColor objectAtIndex:0] floatValue]/255.0 green:[[tempButtonColor objectAtIndex:1] floatValue]/255.0 blue:[[tempButtonColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [callWaiterButton_iPhone setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
    callWaiterButton_iPhone.layer.cornerRadius = 4.0;
    callWaiterButton_iPhone.layer.masksToBounds = YES;
    [[createOrderButton_iPhone titleLabel] setFont:[UIFont fontWithName:@"Roboto-Medium" size:12.0]];
    // style
    [createOrderButton_iPhone setBackgroundColor:[UIColor colorWithRed:[[tempButtonColor objectAtIndex:0] floatValue]/255.0 green:[[tempButtonColor objectAtIndex:1] floatValue]/255.0 blue:[[tempButtonColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [createOrderButton_iPhone setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
    createOrderButton_iPhone.layer.cornerRadius = 4.0;
    createOrderButton_iPhone.layer.masksToBounds = YES;
    [logoTopPanel_iPhone setImage:[[REDOrder sharedIndicatorFiles] companyLogo]];
    menuTableViewHeight = menuTableView_iPhone.frame.size.height;
    
    
    // iPad Device 
    [headerCategoryLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Light" size:24.0]];
    [headerCategoryLabel_iPad setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [headerInBasketLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Regular" size:16.0]];
    [headerInBasketLabel_iPad setTextColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];

    [headerPriceLabel_iPad setFont:[UIFont fontWithName:@"Roboto-Regular" size:16.0]];
    [headerCreateOrderButton_iPad.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:15.0]];
    [headerCreateOrderButton_iPad.titleLabel setShadowColor:[UIColor colorWithRed:135.0/255 green:51.0/255 blue:52.0/255 alpha:0.8]];
    [headerCreateOrderButton_iPad.titleLabel setShadowOffset:CGSizeMake(0, -1)];
    [headerCreateOrderButton_iPad setBackgroundColor:[UIColor colorWithRed:[[tempButtonColor objectAtIndex:0] floatValue]/255.0 green:[[tempButtonColor objectAtIndex:1] floatValue]/255.0 blue:[[tempButtonColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    [headerCreateOrderButton_iPad setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
    headerCreateOrderButton_iPad.layer.cornerRadius = 4.0;
    headerCreateOrderButton_iPad.layer.masksToBounds = YES;
    [menuTableView_iPad.layer setCornerRadius:3.0];
    [menuTableView_iPad.layer setMasksToBounds:YES];
    [logo_iPad setImage:[[REDOrder sharedIndicatorFiles] companyLogo]];
    [logo_iPad.layer setCornerRadius:3.0];
    [logo_iPad.layer setMasksToBounds:YES];
    
    [callWaiterButton_iPad setBackgroundColor:[UIColor colorWithRed:[[tempButtonColor objectAtIndex:0] floatValue]/255.0 green:[[tempButtonColor objectAtIndex:1] floatValue]/255.0 blue:[[tempButtonColor objectAtIndex:2] floatValue]/255.0 alpha:1.0]];
    

    callWaiterButton_iPad.layer.cornerRadius = 4.0;
    callWaiterButton_iPad.layer.masksToBounds = YES;
    [callWaiterButton_iPad.titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:19.0]];
    // All Device
    collectionMenu = [[REDCollectionMenu alloc] init];

    collectionMenu.delegate = self;
    
    objectInRow = 0;
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [collectionMenu.view setFrame:CGRectMake(0, 44, collectionMenu.view.frame.size.width, self.view.bounds.size.height - 44 - 49)];
        objectInRow = self.view.bounds.size.width / 160;
    }
    else
    {
        [collectionMenu.view setFrame:CGRectMake(27, 90, contentView_iPad.frame.size.width, contentView_iPad.frame.size.height - 110)];
        objectInRow = contentView_iPad.frame.size.width / 250;
    }
    
    [contentView_iPhone addSubview:collectionMenu.view];
    [contentView_iPad addSubview:collectionMenu.view];
    

//    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
//    //    [bouton setUserInteractionEnabled:YES];
//    //    [bouton addGestureRecognizer:panGesture];
//    [contentView_iPhone setUserInteractionEnabled:YES];
//    [contentView_iPhone addGestureRecognizer:panGesture];
    
    UIPanGestureRecognizer * pgr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [contentView_iPhone addGestureRecognizer:pgr];
    [contentView_iPhone setUserInteractionEnabled:YES];
    pgr.delegate = self;
    
    [collectionMenu refreshDataWithParametersCountInLine:objectInRow resourceData:allProduct];
}

-(void)handlePan:(UIPanGestureRecognizer *)pgr
{
    if (pgr.state == UIGestureRecognizerStateChanged)
    {
        
        if (contentView_iPhone.frame.origin.x > 0 && contentView_iPhone.frame.origin.x < 258) {
            CGPoint translation = [pgr translationInView:pgr.view];
            CGRect newFrame = contentView_iPhone.frame;
            newFrame.origin.x = newFrame.origin.x + translation.x;
            contentView_iPhone.frame = newFrame;
            [pgr setTranslation:CGPointZero inView:pgr.view];
        }
        else
        {
            if (contentView_iPhone.frame.origin.x < 0) {
                [contentView_iPhone setFrame:CGRectMake(0, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height)];
            }
            else if (contentView_iPhone.frame.origin.x > 258)
            {
                [contentView_iPhone setFrame:CGRectMake(258, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height)];
            }
            else
            {
                
            }
        }
        
    }
    
    if (pgr.state == UIGestureRecognizerStateBegan) {
        if (contentView_iPhone.frame.origin.x == 0) {
            [contentView_iPhone setFrame:CGRectMake(1, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height)];
        }
        else if (contentView_iPhone.frame.origin.x == 258)
        {
            [contentView_iPhone setFrame:CGRectMake(257, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height)];
        }
        else
        {
            
        }
    }
    
    if (pgr.state == UIGestureRecognizerStateEnded) {
        if (contentView_iPhone.frame.origin.x < 158) {
            isMenuViewOpen_iPhone = NO;
            [UIView
             animateWithDuration:0.5
             animations:^{
                 contentView_iPhone.frame = CGRectMake(0, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height);
             }];
        }
        if (contentView_iPhone.frame.origin.x >= 158) {
            isMenuViewOpen_iPhone = YES;
            [UIView
             animateWithDuration:0.5
             animations:^{
                 contentView_iPhone.frame = CGRectMake(258.0, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height);
             }];
        }
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [collectionMenu.view setFrame:CGRectMake(0, 50, collectionMenu.view.frame.size.width, self.view.bounds.size.height - 50 - 49)];
    }
    else
    {
        [collectionMenu.view setFrame:CGRectMake(27, 90, contentView_iPad.frame.size.width, contentView_iPad.frame.size.height - 110)];
    }
    
    backgroundFon_iPhone.image = [[REDOrder sharedIndicatorFiles] companyBackgroundImage];
    NSArray *textColor = [[REDOrder sharedIndicatorFiles] color_text];
    [callWaiterButton_iPad setTitleColor:[UIColor colorWithRed:[[textColor objectAtIndex:0] floatValue]/255.0 green:[[textColor objectAtIndex:1] floatValue]/255.0 blue:[[textColor objectAtIndex:2] floatValue]/255.0 alpha:1.0] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    contentView_iPhone = nil;
    menuTableView_iPhone = nil;
    callWaiterButton_iPhone = nil;
    createOrderButton_iPhone = nil;
    headerCategoryLabel_iPad = nil;
    headerInBasketLabel_iPad = nil;
    headerPriceLabel_iPad = nil;
    headerCreateOrderButton_iPad = nil;
    menuTableView_iPad = nil;
    contentView_iPad = nil;
    mySearchBar_iPhone = nil;
    callWaiterButton_iPad = nil;
    backgroundFon_iPhone = nil;
    [super viewDidUnload];
}

#pragma mark - IBActions

- (IBAction)openMenuButtonPress:(id)sender {
    if (!isMenuViewOpen_iPhone) {
        isMenuViewOpen_iPhone = YES;
        [UIView
         animateWithDuration:0.5
         animations:^{
             contentView_iPhone.frame = CGRectMake(258.0, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height);
         }];
    }
    else if (isMenuViewOpen_iPhone) {
        isMenuViewOpen_iPhone = NO;
        [UIView
         animateWithDuration:0.5
         animations:^{
         contentView_iPhone.frame = CGRectMake(0.0, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height);
         }];
    }

}

-(IBAction)handlePanGesture:(UIPanGestureRecognizer *)sender
{
    CGPoint translate = [sender translationInView:self.view];
    
    CGRect newFrame = contentView_iPhone.frame;
    newFrame.origin.x += translate.x;
    sender.view.frame = newFrame;
    
    if(sender.state == UIGestureRecognizerStateEnded)
        contentView_iPhone.frame = newFrame;
}

#pragma mark - Table View Delegate

- (void)didSelectSection:(UIButton*)sender {
    [menuTableView_iPhone setFrame:CGRectMake(menuTableView_iPhone.frame.origin.x, menuTableView_iPhone.frame.origin.y, menuTableView_iPhone.frame.size.width, menuTableViewHeight)];
    [mySearchBar_iPhone resignFirstResponder];
    NSLog(@"globalSender %i", globalSender.tag);
    NSLog(@" sender %i", sender.tag);
    if (globalSender && globalSender.tag != sender.tag) {
        //Получение текущей секции
        NSMutableDictionary *currentSection = [categories objectAtIndex:globalSender.tag];
        NSLog(@"1%@", [currentSection description]);
        allProduct = [NSMutableDictionary dictionaryWithDictionary:[self separateResourceData:[[REDOrder sharedIndicatorFiles] separateData] categoryID:[currentSection objectForKey:@"id"]]];
        [collectionMenu refreshDataWithParametersCountInLine:objectInRow resourceData:allProduct];
        [headerCategoryLabel_iPad setText:[currentSection objectForKey:@"title"]];
        //Получение элементов секции
        NSArray *items = [currentSection objectForKey:@"items"];
                
        //Создание массива индексов
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i=0; i<items.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:globalSender.tag]];
        }
        //Получение состояния секции
        BOOL isOpen = [[currentSection objectForKey:@"isOpen"] boolValue];
        //Установка нового состояния
        [currentSection setObject:[NSNumber numberWithBool:!isOpen] forKey:@"isOpen"];
        //Анимированное добавление или удаление ячеек секции
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if (isOpen) {
                [menuTableView_iPhone deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                //globalSender = nil;
            } else {
                [menuTableView_iPhone insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                //globalSender = sender;
                
                // varOld indexPath
            }
        } else {
            if (isOpen) {
                [menuTableView_iPad deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                //globalSender = nil;
            } else {
                [menuTableView_iPad insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                //globalSender = sender;
            }
        }
        // Обновление фона кнопки
        if (isOpen) {
            [globalSender setBackgroundColor:[UIColor colorWithRed:39.0/255 green:47.0/255 blue:56.0/255 alpha:1.0]];
        }
        if (!isOpen) {
            [globalSender setBackgroundColor:[UIColor colorWithRed:25.0/255 green:34.0/255 blue:44.0/255 alpha:1.0]];
        }
    }
    
        //Получение текущей секции
        NSMutableDictionary *currentSection = [categories objectAtIndex:sender.tag];
        NSLog(@"1%@", [currentSection description]);
        allProduct = [NSMutableDictionary dictionaryWithDictionary:[self separateResourceData:[[REDOrder sharedIndicatorFiles] separateData] categoryID:[currentSection objectForKey:@"id"]]];
        [collectionMenu refreshDataWithParametersCountInLine:objectInRow resourceData:allProduct];
        [headerCategoryLabel_iPad setText:[currentSection objectForKey:@"title"]];
    

        //Получение элементов секции
        NSArray *items = [currentSection objectForKey:@"items"];
        if ([items count] == 0) {
            if (!isMenuViewOpen_iPhone) {
                isMenuViewOpen_iPhone = YES;
                [UIView
                 animateWithDuration:0.5
                 animations:^{
                     contentView_iPhone.frame = CGRectMake(258.0, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height);
                 }];
            }
            else if (isMenuViewOpen_iPhone) {
                isMenuViewOpen_iPhone = NO;
                [UIView
                 animateWithDuration:0.5
                 animations:^{
                     contentView_iPhone.frame = CGRectMake(0.0, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height);
                 }];
            }
        }
        //Создание массива индексов
        NSMutableArray *indexPaths = [NSMutableArray array];
        for (int i=0; i<items.count; i++) {
            [indexPaths addObject:[NSIndexPath indexPathForRow:i inSection:sender.tag]];
        }
        //Получение состояния секции
        BOOL isOpen = [[currentSection objectForKey:@"isOpen"] boolValue];
        //Установка нового состояния
        [currentSection setObject:[NSNumber numberWithBool:!isOpen] forKey:@"isOpen"];
        //Анимированное добавление или удаление ячеек секции
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            if (isOpen) {
                [menuTableView_iPhone deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                globalSender = nil;
            } else {
                [menuTableView_iPhone insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                globalSender = sender;
                
                // varOld indexPath
            }
        } else {
            if (isOpen) {
                [menuTableView_iPad deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                globalSender = nil;
            } else {
                [menuTableView_iPad insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationTop];
                globalSender = sender;
            }
        }
        // Обновление фона кнопки
        if (isOpen) {
            [sender setBackgroundColor:[UIColor colorWithRed:39.0/255 green:47.0/255 blue:56.0/255 alpha:1.0]];
        }
        if (!isOpen) {
            [sender setBackgroundColor:[UIColor colorWithRed:25.0/255 green:34.0/255 blue:44.0/255 alpha:1.0]];
        }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"2%@", [categories description]);
    return categories.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *currentSection = [categories objectAtIndex:section];
    if ([[currentSection objectForKey:@"isOpen"] boolValue]) {
        NSArray *items = [currentSection objectForKey:@"items"];
        return items.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 258, 50)];
    
    NSDictionary *currentSection = [categories objectAtIndex:section];
    NSString *sectionTitle = [[categories objectAtIndex:section] objectForKey:@"title"];
    BOOL isOpen = [[currentSection objectForKey:@"isOpen"] boolValue];
    NSString *arrowNmae = isOpen? @"arrowUp":@"arrowDown";
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0f, 0.0f, 258, 50.0f);
    button.tag = section;
    [button setBackgroundColor:[UIColor colorWithRed:43.0/255 green:52.0/255 blue:62.0/255 alpha:1.0]];
    [button addTarget:self action:@selector(didSelectSection:) forControlEvents:UIControlEventTouchUpInside];
    [button setImage:[UIImage imageNamed:arrowNmae] forState:UIControlStateNormal];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, 246, 50)];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        [titleLabel setFrame:CGRectMake(12, 0, 210, 50)];
    }
    [titleLabel setText:[NSString stringWithFormat:@"%@", sectionTitle]];
    [titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:17.0]];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    
    UIView *separateLine1 = [[UIView alloc] init];
    [separateLine1 setBackgroundColor:[UIColor colorWithRed:78.0/255 green:89.0/255 blue:101.0/255 alpha:1.0]];
    UIView *separateLine2 = [[UIView alloc] initWithFrame:CGRectMake(4.0, 49, 248.0, 1.0)];
    [separateLine2 setBackgroundColor:[UIColor colorWithRed:32.0/255 green:41.0/255 blue:51.0/255 alpha:1.0]];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [separateLine1 setFrame:CGRectMake(4.0, 48, 248.0, 1.0)];
        [separateLine2 setFrame:CGRectMake(4.0, 49, 248.0, 1.0)];
    } else {
        [separateLine1 setFrame:CGRectMake(2.0, 48, 218.0, 1.0)];
        [separateLine2 setFrame:CGRectMake(2.0, 49, 218.0, 1.0)];
    }
    [button addSubview:titleLabel];
    [tableHeaderView addSubview:button];
    //[tableHeaderView addSubview:titleLabel];
    [tableHeaderView addSubview:separateLine1];
    [tableHeaderView addSubview:separateLine2];
    
    return tableHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *currentSection = [categories objectAtIndex:indexPath.section];
    NSMutableArray *items = [currentSection objectForKey:@"items"];
    NSLog(@"items 8985749857 %@", items);
    NSDictionary *currentItem = [[NSMutableDictionary alloc] initWithDictionary:[items objectAtIndex:indexPath.row] copyItems:YES];
    //NSString *currentItem = [items objectAtIndex:indexPath.row];
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", [currentItem objectForKey:@"catname"]];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 258, 50)];
    [backView setBackgroundColor:[UIColor colorWithRed:43.0/255 green:52.0/255 blue:62.0/255 alpha:1.0]];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 0, 246, 50)];
    [titleLabel setText:[NSString stringWithFormat:@"%@", [currentItem objectForKey:@"catname"]]];
    [titleLabel setFont:[UIFont fontWithName:@"Roboto-Medium" size:15.0]];
    [titleLabel setTextColor:[UIColor colorWithRed:157.0/255 green:203.0/255 blue:255.0/255 alpha:1.0]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    
    UIView *separateLine1 = [[UIView alloc] initWithFrame:CGRectMake(4.0, 48, 248.0, 1.0)];
    [separateLine1 setBackgroundColor:[UIColor colorWithRed:78.0/255 green:89.0/255 blue:101.0/255 alpha:1.0]];
    UIView *separateLine2 = [[UIView alloc] initWithFrame:CGRectMake(4.0, 49, 248.0, 1.0)];
    [separateLine2 setBackgroundColor:[UIColor colorWithRed:32.0/255 green:41.0/255 blue:51.0/255 alpha:1.0]];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [separateLine1 setFrame:CGRectMake(4.0, 48, 248.0, 1.0)];
        [separateLine2 setFrame:CGRectMake(4.0, 49, 248.0, 1.0)];
    } else {
        [separateLine1 setFrame:CGRectMake(2.0, 48, 218.0, 1.0)];
        [separateLine2 setFrame:CGRectMake(2.0, 49, 218.0, 1.0)];
        [titleLabel setFrame:CGRectMake(37, 0, 185, 50)];
    }
    
    [cell addSubview:backView];
    [cell addSubview:titleLabel];
    [cell addSubview:separateLine1];
    [cell addSubview:separateLine2];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    
    [menuTableView_iPhone setFrame:CGRectMake(menuTableView_iPhone.frame.origin.x, menuTableView_iPhone.frame.origin.y, menuTableView_iPhone.frame.size.width, menuTableViewHeight)];
    [mySearchBar_iPhone resignFirstResponder];
    
    NSDictionary *currentSection = [categories objectAtIndex:indexPath.section];
    NSMutableArray *items = [currentSection objectForKey:@"items"];
    NSLog(@"items 8985749857 %@", items);
    NSDictionary *currentItem = [[NSMutableDictionary alloc] initWithDictionary:[items objectAtIndex:indexPath.row] copyItems:YES];
    //cell.textLabel.text = [NSString stringWithFormat:@"%@", [currentItem objectForKey:@"catname"]];
    NSLog(@"category ID %@", [NSString stringWithFormat:@"%@", [currentItem objectForKey:@"id"]]);
    //allProduct = [[self separateResourceData: categoryID:[currentSection objectForKey:@"id"]] copy];
    allProduct = [[self separateResourceData:[[REDOrder sharedIndicatorFiles] separateData] categoryID:[NSString stringWithFormat:@"%@", [currentItem objectForKey:@"id"]]] copy];
    NSLog(@"allProduct %@", allProduct);
    [collectionMenu refreshDataWithParametersCountInLine:objectInRow resourceData:allProduct];
    if (!isMenuViewOpen_iPhone) {
        isMenuViewOpen_iPhone = YES;
        [UIView
         animateWithDuration:0.5
         animations:^{
             contentView_iPhone.frame = CGRectMake(258.0, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height);
         }];
    }
    else if (isMenuViewOpen_iPhone) {
        isMenuViewOpen_iPhone = NO;
        [UIView
         animateWithDuration:0.5
         animations:^{
             contentView_iPhone.frame = CGRectMake(0.0, contentView_iPhone.frame.origin.y, contentView_iPhone.frame.size.width, contentView_iPhone.frame.size.height);
         }];
    }
}

#pragma mark - Methods

- (NSDictionary *)separateResourceData:(NSDictionary *)resourceData categoryID:(NSString *)categoryID
{
    NSMutableDictionary *separateResourceData = [[REDOrder sharedIndicatorFiles] separateData];
    NSArray *resourceDataKeys = [separateResourceData allKeys];
    //NSLog(@"resourceDataKeys %@", separateResourceData);
    NSMutableDictionary *separateSubCatAndProducts = [[NSMutableDictionary alloc] init];
    //NSLog(@"categoryID %@", categoryID);
    for (int i = 0; i < [resourceDataKeys count]; i++) {
        if ([separateResourceData objectForKey:categoryID]) {
            //NSLog(@"3%@", [separateResourceData objectForKey:categoryID]);
            if ([[separateResourceData objectForKey:categoryID] objectForKey:@"subcat"]) {
                NSDictionary *allSubcat = [[separateResourceData objectForKey:categoryID] objectForKey:@"subcat"];
                NSArray *allSubcatKeys = [allSubcat allKeys];
                //NSLog(@"777%@", [[[[REDOrder sharedIndicatorFiles] separateData] objectForKey:categoryID] objectForKey:@"subcat"]);
                for (int n = 0; n < [allSubcatKeys count]; n++) {
                    NSDictionary *tempSubcat = [allSubcat objectForKey:[allSubcatKeys objectAtIndex:n]];
                    //NSLog(@"tempSubcat %@", [tempSubcat objectForKey:@"catname"]);
                    [separateSubCatAndProducts setObject:[tempSubcat objectForKey:@"products"] forKey:[tempSubcat objectForKey:@"catname"]];
                }
            }
            else
            {
                if ([[separateResourceData objectForKey:categoryID] objectForKey:@"products"]) {
                    [separateSubCatAndProducts setObject:[[[[REDOrder sharedIndicatorFiles] separateData] objectForKey:categoryID] objectForKey:@"products"] forKey:[[[[REDOrder sharedIndicatorFiles] separateData] objectForKey:categoryID] objectForKey:@"catname"]];
                }
            
            }
        }
    }
    NSLog(@"www %@", [separateSubCatAndProducts description]);
    return separateSubCatAndProducts;
}

- (void)changeOrderPriceCount
{
    NSDictionary *orderPriceAndCount = [[NSDictionary alloc] initWithDictionary:[[REDOrder sharedIndicatorFiles] getOrderPriceAndCount] copyItems:YES];
    [basketLabel_iPhone setText:[NSString stringWithFormat:@"Корзина (%@)", [orderPriceAndCount objectForKey:@"orderCount"]]];
    [totalPriceLabel_iPhone setText:[NSString stringWithFormat:@"%@грн.", [orderPriceAndCount objectForKey:@"orderPrice"]]];
    [headerInBasketLabel_iPad setText:[NSString stringWithFormat:@"Корзина (%@) - %@грн.", [orderPriceAndCount objectForKey:@"orderCount"], [orderPriceAndCount objectForKey:@"orderPrice"]]];
    [headerPriceLabel_iPad setText:[NSString stringWithFormat:@"%@грн.", [orderPriceAndCount objectForKey:@"orderPrice"]]];
}

#pragma mark - IBActions

- (IBAction)openDetailDish:(id)sender {
    dishDetail = [[REDDishDetail alloc] initWithNibName:@"REDDishDetail_iPad" bundle:nil];
    [self.view addSubview:dishDetail.view];
    //dishDetail.dishDetailCaptionLabel.text = dishID;

}

- (IBAction)createOrderButtonPress:(id)sender
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        orderView = [[REDOrderView alloc] initWithNibName:@"REDOrderView_iPhone" bundle:nil];
        if ([[UIScreen mainScreen] bounds].size.height == 480) {
            [orderView.view setFrame:CGRectMake(0, 0, 320, 480)];
        }
        else
        {
            [orderView.view setFrame:CGRectMake(0, 0, 320, 568)];
        }
    } else {
        orderView = [[REDOrderView alloc] initWithNibName:@"REDOrderView_iPad" bundle:nil];
    }
    
    [self.view addSubview:orderView.view];
}

- (IBAction)callWaiterPress:(id)sender
{
    [[API sharedIndicatorFiles] callStewardWithUserVisitorID:[[REDOrder sharedIndicatorFiles] userID] table:[[REDOrder sharedIndicatorFiles] tableID] success:^(id JSON) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Вызов!" message:@"Вы вызвали официанта!" delegate:nil cancelButtonTitle:@"Ок" otherButtonTitles:nil, nil];
        [alertView show];
    } error:^(id ERROR) {
        
    }];
}

#pragma mark - REDCollectionView Delegate

- (void)openDishDetailView:(NSDictionary *)dishData
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        dishDetail = [[REDDishDetail alloc] initWithNibName:@"REDDishDetail_iPhone" bundle:nil];
        if ([[UIScreen mainScreen] bounds].size.height == 480) {
            [dishDetail.view setFrame:CGRectMake(0, 0, 320, 480)];
            [dishDetail.informationView_iPhone setFrame:CGRectMake(5, 243, 310, 203)];
        }
        else
        {
            [dishDetail.view setFrame:CGRectMake(0, 0, 320, 568)];
            [dishDetail.informationView_iPhone setFrame:CGRectMake(5, 243, 310, 291)];
        }
    }
    else
    {
        dishDetail = [[REDDishDetail alloc] initWithNibName:@"REDDishDetail_iPad" bundle:nil];
    }
    [dishDetail setProductInfo:dishData];
    [self.view addSubview:dishDetail.view];
    [dishDetail setData:dishData];
    //[self presentModalViewController:dishDetail animated:YES];
}

#pragma mark - Search Bar Delegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    menuTableViewHeight = menuTableView_iPhone.frame.size.height;
    [UIView
     animateWithDuration:1
     animations:^{
         [menuTableView_iPhone setFrame:CGRectMake(menuTableView_iPhone.frame.origin.x, menuTableView_iPhone.frame.origin.y, menuTableView_iPhone.frame.size.width, menuTableView_iPhone.frame.size.height - 216)];
     }];
    
    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    
    if ([searchText length] > 2) {
        NSMutableArray *separateCategories = [[NSMutableArray alloc] init];
        NSMutableArray *tempCategoriesEtalon = [[[REDOrder sharedIndicatorFiles] categories] copy];
        for (int i = 0; i < [tempCategoriesEtalon count]; i++)
        {
            NSMutableDictionary *separateCat = [[NSMutableDictionary alloc] init];
            NSDictionary *tempCategory = [tempCategoriesEtalon objectAtIndex:i];
            NSLog(@"tempCategoryName %@", [tempCategory objectForKey:@"title"]);
            NSLog(@"tempCategory %@", tempCategory);
            NSString *string = [[tempCategory objectForKey:@"title"] lowercaseString];
            NSLog(@"string %@", string);
            if ([string rangeOfString:searchText].location == NSNotFound)
            {
                if ([[tempCategory objectForKey:@"items"] count] > 0) {
                    NSMutableArray *separateSubCats = [[NSMutableArray alloc] init];
                    NSArray *tempSubCats = [tempCategory objectForKey:@"items"];
                    for (int n = 0; n < [tempSubCats count]; n++)
                    {
                        NSDictionary *tempSubCatItem = [tempSubCats objectAtIndex:n];
                        NSString *subCatTitle = [[tempSubCatItem objectForKey:@"catname"] lowercaseString];
                        if ([subCatTitle rangeOfString:searchText].location == NSNotFound)
                        {
                            
                        }
                        else
                        {
                            NSMutableDictionary *itemsDictronary = [[NSMutableDictionary alloc] init];
                            [itemsDictronary setObject:[tempSubCatItem objectForKey:@"catname"] forKey:@"catname"];
                            [itemsDictronary setObject:[tempSubCatItem objectForKey:@"id"] forKey:@"id"];
                            [separateSubCats addObject:itemsDictronary];
                        }
                    }
                    if ([separateSubCats count] > 0) {
                        [separateCat setObject:[tempCategory objectForKey:@"id"] forKey:@"id"];
                        [separateCat setObject:[tempCategory objectForKey:@"title"] forKey:@"title"];
                        [separateCat setObject:separateSubCats forKey:@"items"];
                        NSLog(@"separateCat %@", separateCat);
                    }
                    
                }
            }
            else
            {
                if ([[tempCategory objectForKey:@"items"] count] > 0)
                {
                    NSMutableArray *separateSubCats = [[NSMutableArray alloc] init];
                    NSArray *tempSubCats = [tempCategory objectForKey:@"items"];
                    NSLog(@"[tempSubCats count] %i", [tempSubCats count]);
                    for (int n = 0; n < [tempSubCats count]; n++)
                    {
                        NSDictionary *tempSubCatItem = [tempSubCats objectAtIndex:n];
                        NSLog(@"tempSubCatItem %@", tempSubCatItem);
                        NSLog(@"tempSubCatItem %@", [tempSubCatItem objectForKey:@"catname"]);
                        
                        NSString *subCatTitle = [[tempSubCatItem objectForKey:@"catname"] lowercaseString];
                        NSLog(@"subCatTitle %@", subCatTitle);
                        if ([subCatTitle rangeOfString:searchText].location == NSNotFound)
                        {
                            
                        }
                        else
                        {
                            NSMutableDictionary *itemsDictronary = [[NSMutableDictionary alloc] init];
                            [itemsDictronary setObject:[tempSubCatItem objectForKey:@"catname"] forKey:@"catname"];
                            [itemsDictronary setObject:[tempSubCatItem objectForKey:@"id"] forKey:@"id"];
                            [separateSubCats addObject:itemsDictronary];
                        }
                    }
                    [separateCat setObject:[tempCategory objectForKey:@"id"] forKey:@"id"];
                    [separateCat setObject:[tempCategory objectForKey:@"title"] forKey:@"title"];
                    [separateCat setObject:separateSubCats forKey:@"items"];
                    NSLog(@"1 %@", separateSubCats);
                    NSLog(@"1 %@", separateCat);
                    NSLog(@"1 %@", separateCat);
                }
                else
                {
                    // если есть совпадение в категории, но нет совпадений в подкатегориях
                    [separateCat setObject:[tempCategory objectForKey:@"id"] forKey:@"id"];
                    [separateCat setObject:[tempCategory objectForKey:@"title"] forKey:@"title"];
                    [separateCat setObject:[[NSArray alloc] initWithObjects:nil, nil] forKey:@"items"];
                }
            }
            if ([separateCat objectForKey:@"title"]) {
                [separateCategories addObject:separateCat];
            }
            categories = [separateCategories copy];
        }
        [menuTableView_iPad reloadData];
        [menuTableView_iPhone reloadData];
    }
    else
    {
        categories = [[[REDOrder sharedIndicatorFiles] categories] copy];
        [menuTableView_iPad reloadData];
        [menuTableView_iPhone reloadData];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    categories = [[[REDOrder sharedIndicatorFiles] categories] copy];
    [menuTableView_iPad reloadData];
    [menuTableView_iPhone reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    [menuTableView_iPhone setFrame:CGRectMake(menuTableView_iPhone.frame.origin.x, menuTableView_iPhone.frame.origin.y, menuTableView_iPhone.frame.size.width, menuTableViewHeight)];
}

@end
