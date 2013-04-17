//
//  ContentViewController.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "PopViewController.h"

#import "MultiValueDictionary.h"

@interface PopViewController ()
    
@end

@implementation PopViewController

@synthesize strPassedValue, labelMenuName;

@synthesize gridView, items;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization        
        
    }
    return self;
}

- (id)initWithData:(id)data
{
    self = [super init];
    if (self) {
        // Custom initialization
        
        NSLog(@"%@", data);
        
        tree = [[Tree alloc] init];
        
        self.items = [tree getItems:data];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.gridView.autoresizesSubviews = YES;
    self.gridView.delegate = self;
    self.gridView.dataSource = self;
    
    
    [self.view addSubview:gridView];
    
    UIImage * backgroundPattern = [UIImage imageNamed:@"grey-bg.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
    
    if (tree == nil) {
        tree = [[Tree alloc] init];
        
        self.items = [tree getItems:@"root"];
    }   
    
    NSLog(@"hit viewDidLoad");
    
    [self.gridView reloadData];
   
}

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView
{
    return [items count];
}

- (AQGridViewCell *) gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index
{
    static NSString *PlainCellIdentifier = @"PlainCellIdentifier";
    GridViewCell *cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:PlainCellIdentifier];
    if (cell == nil) {
        cell = [[GridViewCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 160, 123) reuseIdentifier:PlainCellIdentifier];
    }
    TreeItem *item = [items objectAtIndex:index];
    [cell.imageView setImage:item.image];
    [cell.captionLabel setText:item.caption];
    return cell;
}

- (CGSize) portraitGridCellSizeForGridView:(AQGridView *)aGridView
{
     return ( CGSizeMake(160.0, 123) );
}

-(void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index
{
    // Create the view controller and initialize it with the
    // next level of data.
    PopViewController *viewController = [[PopViewController alloc]
                                        initWithData:[[items objectAtIndex:index] caption]];
    
    [[self navigationController] pushViewController:viewController
                                           animated:YES];
    /*
    self.items = [tree getItems:[[items objectAtIndex:index] caption]];
    
    if (self.items == nil) {
        NSLog(@"end node2");
    } else {
        [self.gridView reloadData];
    }  
     */
}

- (void)viewWillAppear:(BOOL)animated {
    [labelMenuName setText:strPassedValue];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
