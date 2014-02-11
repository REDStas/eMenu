//
//  REDCollectionCell.m
//  eMenu
//
//  Created by Станислав Редреев on 12.06.13.
//  Copyright (c) 2013 Станислав Редреев. All rights reserved.
//

#import "REDCollectionCell.h"

@implementation REDCollectionCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

#pragma mark - Methods

- (void)initObjectsWithRowCount:(int)rowNumber objectInRow:(int)numberInLine
{
    if (objectArray) {
        for (int i = 0; i < [objectArray count]; i++) {
            [[(REDMeanCellViewController *)[objectArray objectAtIndex:i] view] removeFromSuperview];
        }
        [objectArray removeAllObjects];
    }
    else
    {
        objectArray = [[NSMutableArray alloc] init];
    }
    for (int i = 0; i < numberInLine; i++) {
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
        {
            meanObject = [[REDMeanCellViewController alloc] initWithNibName:@"REDMeanCellViewController" bundle:nil];
        }
        else
        {
            meanObject = [[REDMeanCellViewController alloc] initWithNibName:@"REDMeanCellViewController_iPad" bundle:nil];
        }
        meanObject.delegate = self;
        [meanObject setObjectTag:i + 1];
        [objectArray addObject:meanObject];
        [self addSubview:meanObject.view];
    }
}

- (int)countObjectInCell
{
    return [objectArray count];
}

- (void)setData:(NSArray *)resourceData rowCount:(int)rowNumber
{
    for (int i = 0; i < [resourceData count]; i++) {
        NSDictionary *productData = [[NSDictionary alloc] initWithDictionary:[resourceData objectAtIndex:i]];
        UIView *tempView = [(REDMeanCellViewController *)[objectArray objectAtIndex:i] view];
        [tempView setFrame:CGRectMake(i * tempView.frame.size.width, 0, tempView.frame.size.width, tempView.frame.size.height)];
        [(REDMeanCellViewController *)[objectArray objectAtIndex:i] setProductInfo:productData];
        
        [[(REDMeanCellViewController *)[objectArray objectAtIndex:i] meanNameLabel] setText:[NSString stringWithFormat:@"%@", [productData objectForKey:@"mitemname"]]];
        [[(REDMeanCellViewController *)[objectArray objectAtIndex:i] meanNameLabel_iPad] setText:[NSString stringWithFormat:@"%@", [productData objectForKey:@"mitemname"]]];
        
        NSString *imageURL = [NSString stringWithFormat:@"http://emenu.uran.in.ua/%@", [productData objectForKey:@"image_s"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageURL]];
        AFImageRequestOperation *operation;
        operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil
        success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image)
        {
            [[(REDMeanCellViewController *)[objectArray objectAtIndex:i] meanImage] setImage:image];
            [[(REDMeanCellViewController *)[objectArray objectAtIndex:i] meanImage_iPad] setImage:image];
        }
        failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            NSLog(@"%@", error);
        }];
        [operation start];
        
        [[(REDMeanCellViewController *)[objectArray objectAtIndex:i] meanPrice] setTitle:[NSString stringWithFormat:@"%@", [productData objectForKey:@"price"]] forState:UIControlStateNormal];
        [[(REDMeanCellViewController *)[objectArray objectAtIndex:i] meanPrice_iPad] setTitle:[NSString stringWithFormat:@"%@", [productData objectForKey:@"price"]] forState:UIControlStateNormal];
        
        [[(REDMeanCellViewController *)[objectArray objectAtIndex:i] orderButton] setTag:[(NSString *)[productData objectForKey:@"miid"] intValue]];
        [[(REDMeanCellViewController *)[objectArray objectAtIndex:i] orderButton_iPad] setTag:[(NSString *)[productData objectForKey:@"miid"] intValue]];
    }
}

#pragma mark - REDMeanObject Delegate

- (void)openDishDetailView:(NSDictionary *)dishData
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(openDishDetailView:)]) {
            [self.delegate openDishDetailView:dishData];
        }
    }
}

@end