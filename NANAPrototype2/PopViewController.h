//
//  ContentViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AQGridView.h"

#import "GridViewCell.h"

#import "Tree.h"


@interface PopViewController : UIViewController <AQGridViewDelegate, AQGridViewDataSource> {
    Tree *tree;
}

@property (strong, nonatomic) IBOutlet UILabel *labelMenuName;

@property (strong, nonatomic) NSString *strPassedValue;

@property (nonatomic, retain) IBOutlet AQGridView *gridView;

@property (nonatomic, retain) NSArray *items;

@end



