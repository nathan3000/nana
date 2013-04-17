//
//  GridViewController.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 14/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "GridViewController.h"

@implementation GridViewController

@synthesize gridView, items;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.gridView.autoresizesSubviews = YES;
    self.gridView.delegate = self;
    self.gridView.dataSource = self;
    [self.view addSubview:gridView];
    [self.gridView reloadData];
}

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView
{
    return 6;
}

- (AQGridViewCell *) gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index
{
    static NSString *PlainCellIdentifier = @"PlainCellIdentifier";
    GridViewCell *cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:PlainCellIdentifier];
    if (cell == nil) {
        cell = [[GridViewCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 160, 123) reuseIdentifier:PlainCellIdentifier];
    }
    [cell.imageView setImage:[UIImage imageNamed:@"service-2.jpg"]];
    [cell.captionLabel setText:@"Sample service"];
    return cell;
}

@end
