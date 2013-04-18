//
//  ContentViewController.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "FoodTreeViewController.h"

#import "Helpers.h"

@interface FoodTreeViewController ()

@end

@implementation FoodTreeViewController

@synthesize labelMenuName;

@synthesize selectedMeal;

@synthesize foodTreeContainerView, foodTreeGridView;

@synthesize itemViewController = _itemViewController;

@synthesize itemViewPopover = _itemViewPopover;

@synthesize delegate = _delegate;

@synthesize managedObjectContext = _managedObjectContext;

@synthesize selectedItem = _selectedItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization        
        
    }
    return self;
}

- (id)initWithParent:(id)parent
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.selectedItem = parent;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    // Setup the appearance of the view
    [self setupView];        
            
    // Setup the fetchedResultsController with the food tree items for a given parent item
    [self setupFetchedResultsController:self.selectedItem.name];
        
    // Reload the grid view
    [self.foodTreeGridView reloadData];
}

- (void)setupView
{
    // Set appearance of the view
    [self setAppearance];
    
    // Create food tree view with grid view
    self.foodTreeContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, self.view.bounds.size.height)];
    
    self.foodTreeGridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 10, 1024, self.view.bounds.size.height)];
    self.foodTreeGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.foodTreeGridView.autoresizesSubviews = YES;
    self.foodTreeGridView.delegate = self;
    self.foodTreeGridView.dataSource = self;
    [self.foodTreeContainerView addSubview:self.foodTreeGridView];
    [self.view addSubview:self.foodTreeContainerView];
}

- (void)setAppearance
{    
    // Set the title of the navigation bar
    self.navigationController.navigationBar.topItem.title = @"Food Finder";
    
    // Set the action for the back button
    self.navigationItem.backBarButtonItem =
        [[UIBarButtonItem alloc]
            initWithTitle:@"Back"
                    style:UIBarButtonItemStyleBordered
                   target:self
                   action:@selector(back)
         ];
    
    // Set the action for the cancel button
    self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                 target:self
                                 action:@selector(cancel)
        ];
    
    // Set the background image for the view
    UIImage * backgroundPattern = [UIImage imageNamed:@"grey-bg.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
}

- (void)setupFetchedResultsController:(NSString *)parent
{    
    // Request the FoodTreeItem entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"FoodTreeItem"];
    
    // Filter the results to return only the results with the given parent
    request.predicate = [NSPredicate predicateWithFormat:@"parent = %@", parent];
    
    // Sort the results by position ascending
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"position"                                                                                     ascending:YES]];
    
    // Fetch the results
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:request
                                     managedObjectContext:self.managedObjectContext
                                       sectionNameKeyPath:nil
                                                cacheName:nil];
    [self performFetch];
}

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView
{
    return [[self.fetchedResultsController fetchedObjects] count];
}

- (AQGridViewCell *)gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index
{    
    static NSString *PlainCellIdentifier = @"PlainCellIdentifier";
    GridViewCell *cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:PlainCellIdentifier];       

    if (cell == nil) {
        cell = [[GridViewCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 160*1.25, 123*1.25) reuseIdentifier:PlainCellIdentifier scale:1.25];
    }
    
    Item *item = [[self.fetchedResultsController fetchedObjects] objectAtIndex:index];
    [cell.imageView setImage:[UIImage imageNamed:item.image]];
    [cell.captionLabel setText:item.name];
       
    return cell;
}

-(void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index
{
    FoodTreeItem *selectedItem = [[self.fetchedResultsController fetchedObjects] objectAtIndex:index];
    
    if ([selectedItem.category boolValue] == YES) {
        // Create the view controller and initialize it with the
        // next level of data.
        FoodTreeViewController *viewController = [[FoodTreeViewController alloc]
                                                  initWithParent:selectedItem];        
        viewController.selectedMeal = self.selectedMeal;
        viewController.delegate = self.delegate;
        viewController.managedObjectContext = self.managedObjectContext;
        [[self navigationController] pushViewController:viewController animated:NO];        
    } else {
        // Add selected item to diary
        [Helpers selectItem:selectedItem forMeal:selectedMeal withController:self andContext:self.managedObjectContext];        
        [self dismissModalViewControllerAnimated:YES];
    }    
}

- (CGSize)portraitGridCellSizeForGridView:(AQGridView *)aGridView
{
    return ( CGSizeMake(160.0*1.25, 123*1.25) );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissItemModal
{
    [self.delegate dismissMainPopover];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
