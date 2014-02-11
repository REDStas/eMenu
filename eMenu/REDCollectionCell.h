//
//  REDCollectionCell.h
//  eMenu
//
//  Created by Станислав Редреев on 12.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDMeanCellViewController.h"
#import "AFImageRequestOperation.h"

@protocol REDCollectionCellDelegate <NSObject>

- (void)openDishDetailView:(NSDictionary *)dishData;

@end

@interface REDCollectionCell : UITableViewCell <REDMeanObjectDelegate>
{
    REDMeanCellViewController *meanObject;
    NSMutableArray *objectArray;
}

@property(strong, nonatomic) id <REDCollectionCellDelegate> delegate;

- (int)countObjectInCell;
- (void)initObjectsWithRowCount:(int)rowNumber objectInRow:(int)numberInLine;
- (void)setData:(NSArray *)resourceData rowCount:(int)rowNumber;

@end
