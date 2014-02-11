//
//  REDCollectionMenu.h
//  eMenu
//
//  Created by Станислав Редреев on 12.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "REDCollectionCell.h"

@protocol REDCollectionViewDelegate <NSObject>

- (void)openDishDetailView:(NSDictionary *)dishData;

@end

@interface REDCollectionMenu : UITableViewController <REDCollectionCellDelegate, UITableViewDelegate>
{
    NSMutableDictionary *resourceData;
    NSMutableArray *resourceDataKeys;
    int rowCount;
    int objectsInRow;
}

@property(strong, nonatomic) id <REDCollectionViewDelegate> delegate;

- (void)refreshDataWithParametersCountInLine:(int)countInLine resourceData:(NSDictionary *)data;

@end
