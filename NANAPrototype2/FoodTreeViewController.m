//
//  ContentViewController.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "FoodTreeViewController.h"

#import "MultiValueDictionary.h"

#import "Helpers.h"

@interface FoodTreeViewController ()

@end

@implementation FoodTreeViewController

@synthesize labelMenuName;

@synthesize selectedMeal;

@synthesize foodTreeContainerView, foodTreeGridView;

@synthesize foodTreeItems = _foodTreeItems;

@synthesize itemViewController = _itemViewController;

@synthesize itemViewPopover = _itemViewPopover;

@synthesize delegate = _delegate;

@synthesize managedObjectContext = _managedObjectContext;

@synthesize selectedItem = _selectedItem;

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

- (id)initWithParent:(id)parent
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.selectedItem = parent;
    }
    
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{    
    
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupFetchedResultsController:self.selectedItem.name];
    
    self.navigationController.navigationBar.topItem.title = @"Food Finder";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                             style:UIBarButtonItemStyleBordered
                                                                            target:self
                                                                            action:@selector(back)
                                             ];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                           target:self
                                                                                           action:@selector(cancel)
                                              ];
    
    UIImage * backgroundPattern = [UIImage imageNamed:@"grey-bg.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];
    
    // Create Food Tree view
    self.foodTreeContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, self.view.bounds.size.height)];
    
    self.foodTreeGridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 10, 1024, self.view.bounds.size.height)];
    self.foodTreeGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.foodTreeGridView.autoresizesSubviews = YES;
    self.foodTreeGridView.delegate = self;
    self.foodTreeGridView.dataSource = self;
    
    [self.foodTreeContainerView addSubview:self.foodTreeGridView];
    
    [self.view addSubview:self.foodTreeContainerView];
    
    self.foodTreeItems = [self.fetchedResultsController fetchedObjects];
    
    [self.foodTreeGridView reloadData];
}

- (void)setupFetchedResultsController:(NSString *)parent
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"FoodTreeItem"; // Put your entity name here
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter it if you want
    request.predicate = [NSPredicate predicateWithFormat:@"parent = %@", parent];
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"position"                                                                                     ascending:YES]];
    
    // 5 - Fetch it
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
    [self performFetch];
}

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView
{
    return [self.foodTreeItems count];
}

- (AQGridViewCell *) gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index
{    
    static NSString *PlainCellIdentifier = @"PlainCellIdentifier";
    GridViewCell *cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:PlainCellIdentifier];       

    if (cell == nil) {
        cell = [[GridViewCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 160*1.25, 123*1.25) reuseIdentifier:PlainCellIdentifier scale:1.25];
    }
    
    Item *item = [self.foodTreeItems objectAtIndex:index];
    [cell.imageView setImage:[UIImage imageNamed:item.image]];
    [cell.captionLabel setText:item.name];
       
    return cell;
}

- (CGSize) portraitGridCellSizeForGridView:(AQGridView *)aGridView
{
     return ( CGSizeMake(160.0*1.25, 123*1.25) );
}

-(void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index
{
    FoodTreeItem *selectedItem = [self.foodTreeItems objectAtIndex:index];
    
    /*
    
    if ([selectedItem.category boolValue] == NO) {
        if ([selectedItem.options boolValue] == NO) {
            [Helpers addItemToDiary:selectedItem forMeal:self.selectedMeal withContext:self.managedObjectContext];
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
                        
            self.itemViewController = [[ItemViewController alloc] init];
            
            self.itemViewController.delegate = self;
            
            self.itemViewController.managedObjectContext = self.managedObjectContext;
            
            self.itemViewController.selectedItem = selectedItem;
            
            self.itemViewController.selectedMeal = self.selectedMeal;
            
            //[self presentModalViewController:self.itemViewController andSize:CGSizeMake(500, 500) andModalTransitionStyle:UIModalTransitionStyleCoverVertical];
            
        }        
    } 
     
     */
    
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
        [Helpers selectItem:selectedItem forMeal:selectedMeal withController:self andContext:self.managedObjectContext];
        
        [self dismissModalViewControllerAnimated:YES];
    }    
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
    NSLog(@"hit back button");
    [self.navigationController popViewControllerAnimated:YES];
}

@end
