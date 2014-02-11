//
//  REDViewController.h
//  eMenu
//
//  Created by Станислав Редреев on 28.05.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "REDDishDetail.h"

@interface REDViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    REDDishDetail *dishDetailView;
}

- (IBAction)Button:(id)sender;

@end
