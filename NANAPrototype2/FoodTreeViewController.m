//
//  ContentViewController.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "FoodTreeViewController.h"

#import "MultiValueDictionary.h"

@interface FoodTreeViewController ()
    
@end

@implementation FoodTreeViewController

@synthesize labelMenuName;

@synthesize gridView, items;

@synthesize delegate;

@synthesize managedObjectContext = _managedObjectContext;

- (id)init
{
    self = [super init];
    
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

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
        
        NSLog(@"hit initWithData");
        
        tree = [[Tree alloc] init];
        
        self.items = [tree getItems:data];
        
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contentSizeForViewInPopover = CGSizeMake(1000, 600);
    
    self.gridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height)];
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
    NSLog(@"%@", [items objectAtIndex:index]);
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
    TreeItem *selectedItem = [items objectAtIndex:index];
    
    // Create the view controller and initialize it with the
    // next level of data.
    FoodTreeViewController *viewController = [[FoodTreeViewController alloc]
                                        initWithData:[selectedItem caption]];
    
    self.items = [tree getItems:[selectedItem caption]];
    
    if (self.items == nil) {
        NSLog(@"end node");        
        
        ItemViewController *itemViewController = [[ItemViewController alloc] init];
        
        itemViewController.delegate = self;
        
        itemViewController.managedObjectContext = self.managedObjectContext;
        
        itemViewController.selectedItem = selectedItem;
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:itemViewController];
        
        navigationController.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController:navigationController animated:YES completion:nil];
        
    } else {
        viewController.delegate = self.delegate;
        viewController.managedObjectContext = self.managedObjectContext;
        [[self navigationController] pushViewController:viewController
                                               animated:NO];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    //[labelMenuName setText:strPassedValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissItemModal
{
    NSLog(@"hit dismissItemModal");
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [delegate dismissMainPopover];
    
    
}
@end
