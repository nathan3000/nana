//
//  TreeItem.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 14/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "TreeItem.h"

@implementation TreeItem

@synthesize caption, image;

- (id)initWithCaption:(NSString *)theCaption andImage:(UIImage *)theImage
{
    self = [super init];
    if (self) {
        self.caption = theCaption;
        self.image = theImage;
    }
    return self;
}

@end
