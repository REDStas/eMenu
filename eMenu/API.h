//
//  API.h
//  eMenu
//
//  Created by Станислав Редреев on 10.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFJSONRequestOperation.h"
#import "AFHTTPClient.h"

@interface API : NSObject
{
    AFHTTPClient *httpClient;
    NSDictionary *staticJSONParameters;
}

+ (API *)sharedIndicatorFiles;

// Methods

- (void)clientThemeWithID:(NSString *)clientID success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON;
- (void)connectionWithEmail:(NSString *)email appID:(NSString *)appID appType:(NSString *)appType languageID:(NSString *)languageID success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON;
- (void)tableVisitWithUserVisitorID:(NSString *)userVisitorID filial:(NSString *)filial table:(NSString *)table language:(NSString *)language menu:(NSString *)menu success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON;
- (void)getMenuWithUserVisitorID:(NSString *)userVisitorID filial:(NSString *)filial table:(NSString *)table language:(NSString *)language success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON;
- (void)setOrderWithUserVisitorID:(NSString *)userVisitorID table:(NSString *)table visitorAccessID:(NSString *)visitorAccessID mealsForOrder:(NSString *)mealsForOrder summaryOrder:(NSString *)summaryOrder success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON;
- (void)callStewardWithUserVisitorID:(NSString *)userVisitorID table:(NSString *)table success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON;
- (void)productLikeWithUserVisitorID:(NSString *)userVisitorID mealID:(NSString *)mealID rating:(NSString *)rating success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON;

@end
