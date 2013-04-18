//
//  GridViewCell.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 14/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "GridViewCell.h"

@implementation GridViewCell

@synthesize captionLabel, imageView, frameImageView;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)aReuseIdentifier
{
    return [self initWithFrame:frame reuseIdentifier:aReuseIdentifier scale:1];
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)aReuseIdentifier scale:(float)scale
{
    self = [super initWithFrame:frame reuseIdentifier: aReuseIdentifier];
    
    if (self) {
        // Initialization code
        
        if(!scale) {
            scale = 1;
        }
        
        UIView *mainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160*scale, 123*scale)];
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        [mainView setBackgroundColor:[UIColor clearColor]];
        
        self.frameImageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 4, 142*scale, 117*scale)];
        [self.frameImageView setImage:[UIImage imageNamed:@"tab-mask.png"]];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13, 8, 135*scale, 84*scale)];
        self.captionLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 92*scale, 136*scale, 21)];
        
        self.captionLabel.textAlignment = NSTextAlignmentCenter;
        [captionLabel setFont:[UIFont systemFontOfSize:14]];
        [mainView addSubview:imageView];
        [mainView addSubview:frameImageView];
        [mainView addSubview:captionLabel];
        [self.contentView addSubview:mainView];        
    }
    
    return self;
}

- (void)selectCell
{
    [self.frameImageView setImage:[UIImage imageNamed:@"highlighted-tab-mask"]];
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
