//
//  REDAppDelegate.h
//  eMenu
//
//  Created by Станислав Редреев on 28.05.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REDStartView.h"

@class REDViewController;

@interface REDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) REDStartView *startView;

@end
