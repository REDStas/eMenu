//
//  REDOrder.h
//  eMenu
//
//  Created by Станислав Редреев on 13.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFImageRequestOperation.h"

@interface REDOrder : NSObject
{

}

// User global info
@property(strong, nonatomic) NSString *userID;
@property(strong, nonatomic) NSString *vaID; // visitor access ID
@property(strong, nonatomic) NSString *userLanguage;

// Company global info
@property(strong, nonatomic) NSString *companyID;
@property(strong, nonatomic) NSString *tableID;
@property(strong, nonatomic) UIImage *companyLogo;
@property(strong, nonatomic) UIImage *companyBackgroundImage;
@property(strong, nonatomic) UIImage *companyHomeScreenImage;
@property(strong, nonatomic) NSString *companyColors;
@property(strong, nonatomic) NSArray *color_button;
@property(strong, nonatomic) NSArray *color_order;
@property(strong, nonatomic) NSArray *color_text;
@property(strong, nonatomic) NSString *companyBackgroundColor;

// Global Data
@property(strong, nonatomic) NSMutableDictionary *userOrder;
@property(strong, nonatomic) NSMutableDictionary *favourite;
@property(strong, nonatomic) NSMutableArray *categories;
@property(strong, nonatomic) NSMutableDictionary *resourceData;
@property(strong, nonatomic) NSMutableDictionary *separateData;

+ (REDOrder *)sharedIndicatorFiles;

- (void)setClientStyle:(NSDictionary *)style; 
- (void)setMenuData:(NSDictionary *)menuData;
- (void)addItem:(NSDictionary *)data; // создать, добавить наименование в список
- (void)removeItem:(NSString *)item; // удалить полностью найменование
- (void)removeAllItems;
- (void)moreItem:(NSString *)item; // увеличить колличество
- (void)lessItem:(NSString *)item; // уменьшить колличество
- (NSDictionary *)getOrderPriceAndCount;
- (NSArray *)convertColor:(NSString *)color;

- (void)separateDataForCategories:(NSDictionary *)resourseData;

@end
