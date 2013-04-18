//
//  FoodTreeItem.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 18/04/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Item.h"


@interface FoodTreeItem : Item

@property (nonatomic, retain) NSNumber * category;
@property (nonatomic, retain) id builder;
@property (nonatomic, retain) NSString * parent;
@property (nonatomic, retain) NSNumber * position;

@end
