//
//  REDOrder.m
//  eMenu
//
//  Created by Станислав Редреев on 13.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import "REDOrder.h"

static REDOrder *sharedMySingleton = nil;

@implementation REDOrder

@synthesize userOrder, color_button, color_text, color_order;
@synthesize companyBackgroundImage, companyHomeScreenImage, companyLogo;

+ (REDOrder *)sharedIndicatorFiles
{
    @synchronized([REDOrder class])
    {
        if (!sharedMySingleton)
            sharedMySingleton = [[REDOrder alloc] init];
        
        return sharedMySingleton;
    }
    return nil;
}

+ (id)alloc
{
    @synchronized([REDOrder class])
    {
        NSAssert(sharedMySingleton == nil, @"Attempted to allocate a second instance of a singleton.");
        sharedMySingleton = [super alloc];
        return sharedMySingleton;
    }
    return nil;
}

- (id)init
{
    self = [super init];
    
    if (self != nil)
    {
        userOrder = [[NSMutableDictionary alloc] init];
        [self setDefaultStyle];
    }
    return self;
}

#pragma mark - Methods

- (void)setDefaultStyle
{
    self.companyBackgroundColor = @"0-0-0";
    self.companyColors = @"0-0-255";
    self.color_button = [@"255-0-0" componentsSeparatedByString:@"-"];
    self.color_order = [@"0-255-0" componentsSeparatedByString:@"-"];
    self.color_text = [@"255-255-255" componentsSeparatedByString:@"-"];
    
    NSString *imageURL = [NSString stringWithFormat:@"http://emenu.uran.in.ua/%@", @"assets/files/themeimg/1-client_logo-20130711173818.jpg"];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    AFImageRequestOperation *operation;
    operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
    {
        self.companyLogo = image;
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
    [operation start];
    

    self.companyBackgroundImage = [UIImage imageNamed:@"backgroundMenuFon.png"];

}

- (void)addItem:(NSDictionary *)data
{
    //NSLog(@"%@", data);
    if (![userOrder objectForKey:[data objectForKey:@"miid"]]) {
        NSMutableDictionary *tempProductInfo = [[NSMutableDictionary alloc] init];
        [tempProductInfo setObject:[data objectForKey:@"mitemname"] forKey:@"mitemname"];
        [tempProductInfo setObject:[data objectForKey:@"image_s"] forKey:@"image_s"];
        [tempProductInfo setObject:[data objectForKey:@"image_l"] forKey:@"image_l"];
        [tempProductInfo setObject:[data objectForKey:@"price"] forKey:@"price"];
        [tempProductInfo setObject:[data objectForKey:@"price"] forKey:@"priceXcount"];
        [tempProductInfo setObject:[data objectForKey:@"miid"] forKey:@"miid"];
        [tempProductInfo setObject:@"1" forKey:@"count"];
        [self.userOrder setObject:tempProductInfo forKey:[data objectForKey:@"miid"]];
    }
    else
    {
        NSMutableDictionary *tempProductInfo = [[NSMutableDictionary alloc] init];
        tempProductInfo = [userOrder objectForKey:[data objectForKey:@"miid"]];
        //NSLog(@"tempProductInfo %@", tempProductInfo);
        NSString *tempCount = [tempProductInfo objectForKey:@"count"];
        int tempIntCount = [tempCount intValue];
        tempIntCount += 1;
        NSString *tempPrice = [tempProductInfo objectForKey:@"price"];
        float tempFloatPrice = [tempPrice floatValue];
        float priceXcountFloat = tempFloatPrice * tempIntCount;
        NSString *priceXcount = [NSString stringWithFormat:@"%0.2f", priceXcountFloat];
        [tempProductInfo setObject:[NSString stringWithFormat:@"%@", priceXcount] forKey:@"priceXcount"];
        [tempProductInfo setObject:[NSString stringWithFormat:@"%i", tempIntCount] forKey:@"count"];
        [self.userOrder setObject:tempProductInfo forKey:[data objectForKey:@"miid"]];

//        [tempProductInfo setObject:[data objectForKey:@"mitemname"] forKey:@"mitemname"];
//        [tempProductInfo setObject:[data objectForKey:@"image"] forKey:@"image"];
//        [tempProductInfo setObject:[data objectForKey:@"price"] forKey:@"price"];
//        [tempProductInfo setObject:[data objectForKey:@"1"] forKey:@"count"];
//        [self.userOrder setObject:tempProductInfo forKey:[data objectForKey:@"miid"]];
//        
//        
//        NSString *tempCount = [self.userOrder objectForKey:nil];
//        int tempIntCount = [tempCount intValue];
//        tempIntCount += 1;
//        [self.userOrder setObject:[NSString stringWithFormat:@"%i", tempIntCount] forKey:nil];
    }    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change_order_price_and_count" object:nil];
    
    //NSLog(@"%@", [userOrder description]);
}

- (void)removeItem:(NSString *)item
{
    if ([userOrder objectForKey:item]) {
        [self.userOrder removeObjectForKey:item];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"change_order_price_and_count" object:nil];
    }
}

- (void)removeAllItems
{
    [userOrder removeAllObjects];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change_order_price_and_count" object:nil];
}

- (void)moreItem:(NSString *)item
{
    if ([userOrder objectForKey:item]) {
        NSMutableDictionary *tempProductInfo = [[NSMutableDictionary alloc] init];
        tempProductInfo = [userOrder objectForKey:item];
        NSLog(@"tempProductInfo %@", tempProductInfo);
        NSString *tempCount = [tempProductInfo objectForKey:@"count"];
        int tempIntCount = [tempCount intValue];
        tempIntCount += 1;
        [tempProductInfo setObject:[NSString stringWithFormat:@"%i", tempIntCount] forKey:@"count"];
        
        
        NSString *tempPrice = [tempProductInfo objectForKey:@"price"];
        float tempFloatPrice = [tempPrice floatValue];
        float priceXcountFloat = tempFloatPrice * tempIntCount;
        NSString *priceXcount = [NSString stringWithFormat:@"%0.2f", priceXcountFloat];
        [tempProductInfo setObject:[NSString stringWithFormat:@"%@", priceXcount] forKey:@"priceXcount"];
        NSLog(@"tempProductInfo %@", tempProductInfo);
        [self.userOrder setObject:tempProductInfo forKey:item];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"change_order_price_and_count" object:nil];
    }
}

- (void)lessItem:(NSString *)item
{
    if ([userOrder objectForKey:item]) {
        NSMutableDictionary *tempProductInfo = [[NSMutableDictionary alloc] init];
        tempProductInfo = [userOrder objectForKey:item];
        //NSLog(@"tempProductInfo %@", tempProductInfo);
        NSString *tempCount = [tempProductInfo objectForKey:@"count"];
        int tempIntCount = [tempCount intValue];
        if (tempIntCount > 1) {
            tempIntCount -= 1;
            [tempProductInfo setObject:[NSString stringWithFormat:@"%i", tempIntCount] forKey:@"count"];
            
            NSString *tempPrice = [tempProductInfo objectForKey:@"price"];
            float tempFloatPrice = [tempPrice floatValue];
            float priceXcountFloat = tempFloatPrice * tempIntCount;
            NSString *priceXcount = [NSString stringWithFormat:@"%0.2f", priceXcountFloat];
            [tempProductInfo setObject:[NSString stringWithFormat:@"%@", priceXcount] forKey:@"priceXcount"];
            NSLog(@"tempProductInfo %@", tempProductInfo);

            [self.userOrder setObject:tempProductInfo forKey:item];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"change_order_price_and_count" object:nil];
        }        
    }
}

- (NSDictionary *)getOrderPriceAndCount
{
    CGFloat price = 0.0;
    NSMutableDictionary *answer = [[NSMutableDictionary alloc] init];
    NSString *orderCount = [NSString stringWithFormat:@"%i", [[self.userOrder allKeys] count]];
    [answer setObject:orderCount forKey:@"orderCount"];
    NSArray *keys = [[NSArray alloc] initWithArray:[self.userOrder allKeys]];
    for (int i = 0; i < [keys count]; i++) {
        NSString *tempStringPrice = [[self.userOrder objectForKey:[keys objectAtIndex:i]] objectForKey:@"price"];
        CGFloat tempPrice = [tempStringPrice floatValue];
        NSString *tempStringCount = [[self.userOrder objectForKey:[keys objectAtIndex:i]] objectForKey:@"count"];
        int tempCount = [tempStringCount intValue];
        CGFloat tempTotalPrice = tempPrice * tempCount;
        price += tempTotalPrice;
    }
    [answer setObject:[NSString stringWithFormat:@"%0.2f", price] forKey:@"orderPrice"];
    return answer;
}

#pragma mark - Style

- (void)setClientStyle:(NSDictionary *)style
{
    self.companyID = [style objectForKey:@"cid"];
    NSLog(@"style %@", style);
    // companyLogo
    NSString *imageURL = [NSString stringWithFormat:@"http://emenu.uran.in.ua/%@", [style objectForKey:@"client_logo"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
    AFImageRequestOperation *operation;
    operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
    {
        self.companyLogo = image;
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        NSLog(@"%@", error);
    }];
    [operation start];
    
    // company Background
    NSString *imageURL2 = [NSString stringWithFormat:@"http://emenu.uran.in.ua/assets/files/themeimg/%@", [style objectForKey:@"background"]];
    NSLog(@"background path %@", imageURL2);
    NSURLRequest *request2 = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL2]];
    AFImageRequestOperation *operation2;
    operation2 = [AFImageRequestOperation imageRequestOperationWithRequest:request2 imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
    {
        self.companyBackgroundImage = image;
    }
    failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        self.companyBackgroundImage = [UIImage imageNamed:@"backgroundMenuFon.png"];
        NSLog(@"%@", error);
    }];
    [operation2 start];
    
    // company Home Screen
    NSString *imageURL3 = [NSString stringWithFormat:@"http://emenu.uran.in.ua/%@", [style objectForKey:@"home_screen"]];
    NSLog(@"background path %@", imageURL3);
    NSURLRequest *request3 = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL3]];
    AFImageRequestOperation *operation3;
    operation3 = [AFImageRequestOperation imageRequestOperationWithRequest:request3 imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
                  {
                      self.companyHomeScreenImage = image;
                  }
                                                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                                       //self.companyHomeScreenImage = [UIImage imageNamed:@""];
                                                                       NSLog(@"%@", error);
                                                                   }];
    [operation3 start];

    self.companyBackgroundColor = [style objectForKey:@"background"];
    self.companyColors = [style objectForKey:@"colors"];
    self.color_button = [[style objectForKey:@"color_button"] componentsSeparatedByString:@"-"];
    self.color_order = [[style objectForKey:@"color_order"] componentsSeparatedByString:@"-"];
    self.color_text = [[style objectForKey:@"color_text"] componentsSeparatedByString:@"-"];

    NSLog(@"%@", self.companyColors);
}

- (void)setMenuData:(NSDictionary *)menuData
{
    self.favourite = [[menuData objectForKey:@"0"] copy];
    NSMutableArray *allCategoryKeysNonSorted = [[NSMutableArray alloc] initWithArray:[menuData allKeys]];
    NSArray *allCategoryKeys = [allCategoryKeysNonSorted sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *categories = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [allCategoryKeys count]; i++) {
        NSMutableDictionary *categorie = [[NSMutableDictionary alloc] init];
        //NSLog(@"bla %@", [allCategoryKeys objectAtIndex:i]);
        if ([[menuData objectForKey:[allCategoryKeys objectAtIndex:i]] isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *tempCategory = [[NSMutableDictionary alloc] initWithDictionary:[menuData objectForKey:[allCategoryKeys objectAtIndex:i]]];
            if ([tempCategory objectForKey:@"subcat"]) {
                NSArray *allSubCatKeys = [[NSArray alloc] initWithArray:[[tempCategory objectForKey:@"subcat"] allKeys]];
                //NSLog(@"all sub keys %@", allSubCatKeys);
                NSMutableArray*subCategories = [[NSMutableArray alloc] init];
                for (int j = 0; j < [allSubCatKeys count]; j++) {
                    //NSLog(@"all sub keys %@", allSubCatKeys);
                    //NSLog(@"tempCategory %@", [tempCategory description]);
                    NSMutableDictionary *tempSubCat = [[NSMutableDictionary alloc] initWithDictionary:[[tempCategory objectForKey:@"subcat"] objectForKey:[allSubCatKeys objectAtIndex:j]]];
                    NSMutableDictionary *array = [[NSMutableDictionary alloc] init];
                    [array setObject:[NSString stringWithFormat:@"%@", [tempSubCat objectForKey:@"catname"]] forKey:@"catname"];
                    [array setObject:[NSString stringWithFormat:@"%@", [tempSubCat objectForKey:@"catid"]] forKey:@"id"];
                    [subCategories addObject:array];
                    //[subCategories setObject:[tempSubCat objectForKey:@"catid"] forKey:[tempSubCat objectForKey:@"catname"]];
                }
                [categorie setObject:subCategories forKey:@"items"];
                [categorie setObject:[tempCategory objectForKey:@"catname"] forKey:@"title"];
                [categorie setObject:[tempCategory objectForKey:@"catid"] forKey:@"id"];
            }
            else
            {
                
                NSLog(@"tempCategory - %@", tempCategory);
                [categorie setObject:[[NSArray alloc] init] forKey:@"items"];
                [categorie setObject:[tempCategory objectForKey:@"catname"] forKey:@"title"];
                [categorie setObject:[tempCategory objectForKey:@"catid"] forKey:@"id"];
            }
        }
        [categories addObject:categorie];
    }
    self.categories = categories;
    NSLog(@"categories - %@", [self.categories description]);
}



- (void)separateDataForCategories:(NSDictionary *)resourseData
{
    NSLog(@"5%@", resourseData);
    NSMutableArray *categoryKey = [[NSMutableArray alloc] initWithArray:[resourseData allKeys]];
    //NSLog(@"%@", [categoryKey description]);
    
    NSMutableDictionary *separateCategories = [[NSMutableDictionary alloc] init];//65546456456456
    for (int i = 0; i < [categoryKey count]; i++) {
        
        
        if ([[resourseData objectForKey:[categoryKey objectAtIndex:i]] isKindOfClass:[NSDictionary class]]) {
            NSMutableDictionary *tempCategory = [[NSMutableDictionary alloc] initWithDictionary:[resourseData objectForKey:[categoryKey objectAtIndex:i]] copyItems:YES];
            NSLog(@"6%@", [tempCategory description]);
            if ([tempCategory objectForKey:@"products"]) { //если в словаре уже есть продукты
                NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
                [temp setObject:[tempCategory objectForKey:@"catname"] forKey:@"catname"];
                [temp setObject:[tempCategory objectForKey:@"products"] forKey:@"products"];
                
                [separateCategories setObject:temp forKey:[tempCategory objectForKey:@"catid"]]; ///84874847
            }
            else
            {
                if ([tempCategory objectForKey:@"subcat"]) {
                    //NSMutableDictionary *mainCategoryProducts = [[NSMutableDictionary alloc] init]; // сюда записываються продукты с подкатегорий
                    [separateCategories setObject:tempCategory forKey:[tempCategory objectForKey:@"catid"]];
                    
                    NSMutableDictionary *subCats = [[NSMutableDictionary alloc] initWithDictionary:[tempCategory objectForKey:@"subcat"] copyItems:YES];
                    
                    NSMutableArray *subCutKeys = [[NSMutableArray alloc] initWithArray:[subCats allKeys] copyItems:YES];
                    for (int n = 0; n < [subCutKeys count]; n++) {
                        NSMutableDictionary *tempSubCat = [[NSMutableDictionary alloc] initWithDictionary:[subCats objectForKey:[subCutKeys objectAtIndex:n]] copyItems:YES];
                        NSMutableDictionary *temp = [[NSMutableDictionary alloc] init];
                        [temp setObject:[tempSubCat objectForKey:@"catname"] forKey:@"catname"];
                        [temp setObject:[tempSubCat objectForKey:@"products"] forKey:@"products"];
                        if ([tempSubCat objectForKey:@"catid"]) {
                            [separateCategories setObject:temp forKey:[tempSubCat objectForKey:@"catid"]];
                        }
                    
                    }
                    
                    
                }
            }
        }
        
    }
    self.separateData = separateCategories;
    NSLog(@"separateCategories %@", [separateCategories description]);
}

- (NSArray *)convertColor:(NSString *)color
{
//    NSMutableArray *colorArray = [[NSMutableArray alloc] init];
//    unsigned resultRed = 0;
//    NSScanner *scannerRed = [NSScanner scannerWithString:[NSString stringWithFormat:@"#%@", [buttonColorHex substringWithRange:NSMakeRange(1, 2)]]];
//    [scannerRed setScanLocation:1]; // bypass '#' character
//    [scannerRed scanHexInt:&resultRed];
//    unsigned resultGreen = 0;
//    NSScanner *scannerGreen = [NSScanner scannerWithString:[NSString stringWithFormat:@"#%@", [buttonColorHex substringWithRange:NSMakeRange(3, 2)]]];
//    [scannerGreen setScanLocation:1]; // bypass '#' character
//    [scannerGreen scanHexInt:&resultGreen];
//    unsigned resultBlue = 0;
//    NSScanner *scannerBlue = [NSScanner scannerWithString:[NSString stringWithFormat:@"#%@", [buttonColorHex substringWithRange:NSMakeRange(5, 2)]]];
//    [scannerBlue setScanLocation:1]; // bypass '#' character
//    [scannerBlue scanHexInt:&resultBlue];
//    NSLog(@"rgb %i - %i - %i", resultRed, resultGreen, resultBlue);
//    
    return nil;
}

@end
