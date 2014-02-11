//
//  REDMenuView.h
//  eMenu
//
//  Created by Станислав Редреев on 10.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

#import "API.h"
#import "REDDishDetail.h"
#import "REDOrderView.h"
#import "REDCollectionMenu.h"

@interface REDMenuView : UIViewController <REDCollectionViewDelegate, UITableViewDataSource, UISearchBarDelegate, UIGestureRecognizerDelegate>
{
    // iPhone Device
    IBOutlet UIImageView *logoTopPanel_iPhone;
    IBOutlet UILabel *basketLabel_iPhone;
    IBOutlet UILabel *totalPriceLabel_iPhone;
    IBOutlet UIView *contentView_iPhone;
    IBOutlet UITableView *menuTableView_iPhone;
    IBOutlet UIButton *callWaiterButton_iPhone;
    IBOutlet UIButton *createOrderButton_iPhone;
    IBOutlet UISearchBar *mySearchBar_iPhone;
    IBOutlet UIImageView *backgroundFon_iPhone;
    CGFloat menuTableViewHeight;
    
    
    BOOL isMenuViewOpen_iPhone;
    
    // iPad Device
    IBOutlet UILabel *headerCategoryLabel_iPad;
    IBOutlet UILabel *headerInBasketLabel_iPad;
    IBOutlet UILabel *headerPriceLabel_iPad;
    IBOutlet UIButton *headerCreateOrderButton_iPad;
    IBOutlet UITableView *menuTableView_iPad;
    IBOutlet UIView *contentView_iPad;
    IBOutlet UIImageView *logo_iPad;
    IBOutlet UIButton *callWaiterButton_iPad;
    
    
    // All Device
    REDCollectionMenu *collectionMenu;
    //IBOutlet REDCollectionMenu *collectionMenu;
    REDDishDetail *dishDetail;
    REDOrderView *orderView;
    
    // All Data
    NSMutableDictionary *meansData;
    NSMutableDictionary *allProduct;
    NSArray *categories;
    int objectInRow;
    
    UIButton *globalSender;
}
//@property (strong, nonatomic) NSArray *students;

- (IBAction)openMenuButtonPress:(id)sender;
- (IBAction)openDetailDish:(id)sender;
- (IBAction)createOrderButtonPress:(id)sender;
- (IBAction)callWaiterPress:(id)sender;

@end
