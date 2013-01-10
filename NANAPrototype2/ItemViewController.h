//
//  ItemViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 19/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CoreDataTableViewController.h"

#import "Diary.h"

#import "TreeItem.h"

@protocol ItemViewControllerDelegate <NSObject>

- (void)dismissItemModal;

@end

@interface ItemViewController : UIViewController

@property (weak) id delegate;

@property (strong, nonatomic) TreeItem *selectedItem;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
