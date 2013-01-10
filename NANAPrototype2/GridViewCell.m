//
//  GridViewCell.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 14/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "GridViewCell.h"

@implementation GridViewCell

@synthesize captionLabel, imageView;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)aReuseIdentifier
{
    self = [super initWithFrame:frame reuseIdentifier: aReuseIdentifier];
    
    if (self) {
        // Initialization code
        UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 123)];
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [mainView setBackgroundColor:[UIColor clearColor]];
        
        UIImageView *frameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 4, 142, 117)];
        [frameImageView setImage:[UIImage imageNamed:@"tab-mask.png"]];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 8, 135, 84)];
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 92, 127, 21)];
        self.captionLabel.textAlignment = NSTextAlignmentCenter;
        [captionLabel setFont:[UIFont systemFontOfSize:14]];
        [mainView addSubview:imageView];
        [mainView addSubview:frameImageView];
        [mainView addSubview:captionLabel];
        [self.contentView addSubview:mainView];        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
