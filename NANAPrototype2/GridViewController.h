//
//  GridViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 14/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AQGridView.h"


#import "GridViewCell.h"


@interface GridViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource>

@property (nonatomic, retain) IBOutlet AQGridView *gridView;

@property (nonatomic, retain) NSArray *items;

@end
