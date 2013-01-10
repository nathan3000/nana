//
//  Tree.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 15/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TreeItem.h"

#import "MultiValueDictionary.h"

@interface Tree : NSObject {
    MultiValueDictionary *_tree;
}

- (NSArray *)getItems:(id)aKey;

@end
