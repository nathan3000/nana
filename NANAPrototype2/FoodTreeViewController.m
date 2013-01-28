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

@synthesize selectedMeal;

@synthesize foodTreeContainerView, foodTreeGridView, foodTreeItems;

@synthesize itemViewController = _itemViewController;

@synthesize itemViewPopover = _itemViewPopover;

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
        
        self.foodTreeItems = [tree getItems:data];
        
    }
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{    
    
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBar.topItem.title = @"Food Finder";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    
    
    [self setupFetchedResultsController];
    
    UIImage * backgroundPattern = [UIImage imageNamed:@"grey-bg.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
    
    // Create Food Tree view
    self.foodTreeContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 180)];
    
    self.foodTreeGridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.foodTreeGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.foodTreeGridView.autoresizesSubviews = YES;
    self.foodTreeGridView.delegate = self;
    self.foodTreeGridView.dataSource = self;
    
    [self.foodTreeContainerView addSubview:self.foodTreeGridView];
    
    [self.view addSubview:self.foodTreeContainerView];
    
    if (tree == nil) {
        tree = [[Tree alloc] init];
        
        self.foodTreeItems = [tree getItems:@"root"];
    }
    
    [self.foodTreeGridView reloadData];
}

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView
{
    return [foodTreeItems count];
}

- (AQGridViewCell *) gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index
{    
    static NSString *PlainCellIdentifier = @"PlainCellIdentifier";
    GridViewCell *cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:PlainCellIdentifier];       

    if (cell == nil) {
        cell = [[GridViewCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 160, 123) reuseIdentifier:PlainCellIdentifier];
    }
    
    TreeItem *item = [foodTreeItems objectAtIndex:index];
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
    TreeItem *selectedItem = [[TreeItem alloc] init];
    
    selectedItem = [foodTreeItems objectAtIndex:index];

    
    // Create the view controller and initialize it with the
    // next level of data.
    FoodTreeViewController *viewController = [[FoodTreeViewController alloc]
                                              initWithData:[selectedItem caption]];
    
    viewController.selectedMeal = self.selectedMeal;
    
    self.foodTreeItems = [tree getItems:[selectedItem caption]];
    
    if (self.foodTreeItems == nil) {
        
        self.itemViewController = [[ItemViewController alloc] init];
        
        self.itemViewController.delegate = self;
        
        self.itemViewController.managedObjectContext = self.managedObjectContext;
        
        self.itemViewController.selectedItem = selectedItem;
        
        self.itemViewController.selectedMeal = self.selectedMeal;
        
        self.itemViewPopover = [[UINavigationController alloc] initWithRootViewController:_itemViewController];
        
        self.itemViewPopover.modalPresentationStyle = UIModalPresentationFormSheet;
        
        [self presentViewController:self.itemViewPopover animated:YES completion:nil];
        
    } else {
        viewController.delegate = self.delegate;
        viewController.managedObjectContext = self.managedObjectContext;
        [[self navigationController] pushViewController:viewController
                                               animated:NO];
    }

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissItemModal
{
    [delegate dismissMainPopover];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)setupFetchedResultsController
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Diary"; // Put your entity name here
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter it if you want
    //request.predicate = [NSPredicate predicateWithFormat:@"%K like %@", @"meal", meal];
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"label"
                                                                                     ascending:YES
                                                                                      selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    [self performFetch];
}

@end
