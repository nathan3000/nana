//
//  FoodTreeItem.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/04/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Item.h"


@interface FoodTreeItem : Item

@property (nonatomic, retain) NSNumber * category;
@property (nonatomic, retain) NSNumber * options;
@property (nonatomic, retain) NSNumber * position;
@property (nonatomic, retain) NSString * parent;

@end
