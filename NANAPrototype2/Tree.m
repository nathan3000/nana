//
//  Tree.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 15/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "Tree.h"

@interface Tree()

@end

@implementation Tree 

- (id)init
{
    self = [super init];
    
    if (self) {
        
        _tree = [[MultiValueDictionary alloc] init];
        
        TreeItem *item1 = [[TreeItem alloc] initWithCaption:@"Drinks" andImage:[UIImage imageNamed:@"drinks.jpg"]];
        TreeItem *item2 = [[TreeItem alloc] initWithCaption:@"Bread" andImage:[UIImage imageNamed:@"bread.jpg"]];
        
        [_tree addObject:item1 forKey:@"root"];
        [_tree addObject:item2 forKey:@"root"];
        
        TreeItem *item3 = [[TreeItem alloc] initWithCaption:@"Orange Juice" andImage:[UIImage imageNamed:@"orange-juice.jpg"]];
        
        [_tree addObject:item3 forKey:@"Drinks"];
        

    }
    
    return self;
}

- (NSArray *)getItems:(id)aKey
{
    return [_tree objectsForKey:aKey];
}



@end
