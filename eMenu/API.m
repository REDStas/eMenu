//
//  API.m
//  eMenu
//
//  Created by Станислав Редреев on 10.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import "API.h"

@implementation API

static API* sharedMySingleton = nil;

+ (API*)sharedIndicatorFiles
{
    @synchronized([API class])
    {
        if (!sharedMySingleton)
            sharedMySingleton = [[API alloc] init];
        
        return sharedMySingleton;
    }
    return nil;
}

+ (id)alloc
{
    @synchronized([API class])
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
        NSURL *url = [NSURL URLWithString:@"http://emenu.uran.in.ua"];
        httpClient = [[AFHTTPClient alloc] initWithBaseURL:url];
        // массив с обязательными параметрами добавляем его в каждом методе в params
        staticJSONParameters = [[NSDictionary alloc] initWithObjectsAndKeys:
                                @"9DX7qlkeBKLgOd25dYSowSzhNE9ary8E", @"security",
                                nil];
    }
    return self;
}

// Methods

- (void)clientThemeWithID:(NSString *)clientID success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"clienttheme", @"action",
                                   clientID, @"cid",
                                   nil];
    [parameters addEntriesFromDictionary:staticJSONParameters];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api" parameters:parameters];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        successJSON(JSON);
        //NSLog(@"API clientTheme - %@", JSON);
    } failure:^(NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id JSON ) {
        failureJSON(error);
        //NSLog(@"API-ERROR clientTheme - %@", error);
    }];
    [operation start];
}

- (void)connectionWithEmail:(NSString *)email appID:(NSString *)appID appType:(NSString *)appType languageID:(NSString *)languageID success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON;
{
    NSLog(@"%@", email);
    NSLog(@"%@", appID);
    NSLog(@"%@", languageID);
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"connection", @"action",
                                       email, @"email",
                                       appID, @"app_id",
                                       appType, @"app_type",
                                       languageID, @"lid",
                                       nil];
    [parameters addEntriesFromDictionary:staticJSONParameters];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api" parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        successJSON(JSON);
        //NSLog(@"API connection - %@", JSON);
    } failure:^(NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id JSON ) {
        failureJSON(JSON);
       //NSLog(@"API-ERROR connection - %@", error);
    }];
    [operation start];
}

- (void)tableVisitWithUserVisitorID:(NSString *)userVisitorID filial:(NSString *)filial table:(NSString *)table language:(NSString *)language menu:(NSString *)menu success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON
{
    NSLog(@"lang %@", language);
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"tablevisit", @"action",
                                       userVisitorID, @"uvid",
                                       filial, @"fid",
                                       table, @"tid",
                                       language, @"lid",
                                       menu, @"menu",
                                       nil];
    [parameters addEntriesFromDictionary:staticJSONParameters];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    NSLog(@"%@", parameters);
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api" parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        successJSON(JSON);
        //NSLog(@"API tableVisit - %@", JSON);
    } failure:^(NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id JSON ) {
        failureJSON(error);
        //NSLog(@"API-ERROR tableVisit - %@", error);
    }];
    [operation start];
}

- (void)getMenuWithUserVisitorID:(NSString *)userVisitorID filial:(NSString *)filial table:(NSString *)table language:(NSString *)language success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"getmenu", @"action",
                                       userVisitorID, @"uvid",
                                       filial, @"fid",
                                       table, @"tid",
                                       language, @"lid",
                                       nil];
    [parameters addEntriesFromDictionary:staticJSONParameters];
    [AFJSONRequestOperation addAcceptableContentTypes:[NSSet setWithObject:@"text/html"]];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api" parameters:parameters];    
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        successJSON(JSON);
        NSLog(@"API getMenu - %@", JSON);
    } failure:^(NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id JSON ) {
        failureJSON(JSON);
        NSLog(@"API-ERROR getMenu - %@", JSON);
    }];
    [operation start];
}

- (void)setOrderWithUserVisitorID:(NSString *)userVisitorID table:(NSString *)table visitorAccessID:(NSString *)visitorAccessID mealsForOrder:(NSString *)mealsForOrder summaryOrder:(NSString *)summaryOrder success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON;
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"setorder", @"action",
                                       userVisitorID, @"uvid",
                                       table, @"tid",
                                       visitorAccessID, @"vaid",
                                       mealsForOrder, @"miid",
                                       summaryOrder, @"sum",
                                       nil];
    [parameters addEntriesFromDictionary:staticJSONParameters];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api" parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        successJSON(JSON);
        NSLog(@"API setOrder - %@", JSON);
    } failure:^(NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id JSON ) {
        failureJSON(JSON);
        NSLog(@"API-ERROR setOrder - %@", JSON);
    }];
    [operation start];
}

- (void)callStewardWithUserVisitorID:(NSString *)userVisitorID table:(NSString *)table success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON;
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"callsteward", @"action",
                                       userVisitorID, @"uvid",
                                       table, @"tid",
                                       nil];
    [parameters addEntriesFromDictionary:staticJSONParameters];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api" parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        successJSON(JSON);
        NSLog(@"API callSteward - %@", JSON);
    } failure:^(NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id JSON ) {
        failureJSON(JSON);
        NSLog(@"API-ERROR callSteward - %@", error);
    }];
    [operation start];
}

- (void)productLikeWithUserVisitorID:(NSString *)userVisitorID mealID:(NSString *)mealID rating:(NSString *)rating success:(void (^)(id JSON))successJSON error:(void (^)(id ERROR))failureJSON
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"productlike", @"action",
                                       userVisitorID, @"uvid",
                                       mealID, @"lmiid",
                                       rating, @"rating",
                                       nil];
    [parameters addEntriesFromDictionary:staticJSONParameters];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST" path:@"/api" parameters:parameters];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        successJSON(JSON);
        NSLog(@"API productLike - %@", JSON);
    } failure:^(NSURLRequest *request , NSHTTPURLResponse *response , NSError *error , id JSON ) {
        failureJSON(JSON);
        NSLog(@"API-ERROR productLike - %@", JSON);
    }];
    [operation start];
}

@end
