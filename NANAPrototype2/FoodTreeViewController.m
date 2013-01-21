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

@synthesize favouritesContainerView, favouritesGridView, favouriteItems;

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
    [self setupFetchedResultsController:self.selectedMeal];
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    
    int yoffset = 0;
    
    if([sectionInfo numberOfObjects] != 0)
    {        
        yoffset = 180;
        
        self.favouritesContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 180)];
        
        UILabel *favouritesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
        [favouritesLabel setText:@"Favourites"];
        favouritesLabel.font = [UIFont systemFontOfSize:23];
        favouritesLabel.textColor = [UIColor whiteColor];
        favouritesLabel.backgroundColor = [UIColor clearColor];
        [self.favouritesContainerView addSubview:favouritesLabel];
        
        self.favouritesGridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height)];
        self.favouritesGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.favouritesGridView.autoresizesSubviews = YES;
        self.favouritesGridView.delegate = self;
        self.favouritesGridView.dataSource = self;
        
        [self.favouritesContainerView addSubview:self.favouritesGridView];
        
        [self.view addSubview:self.favouritesContainerView];
        
        if (favouriteItems == nil) {
            self.favouriteItems = [[self.fetchedResultsController fetchedObjects] valueForKey:@"label"];
        }
    } else {
        self.favouriteItems = nil;
        [[self.view subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    }    
    
    // Create Food Tree view
    self.foodTreeContainerView = [[UIView alloc] initWithFrame:CGRectMake(0, yoffset, 1000, 180)];
    
    UILabel *foodTreeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 30)];
    [foodTreeLabel setText:@"Food Tree"];
    foodTreeLabel.font = [UIFont systemFontOfSize:23];
    foodTreeLabel.textColor = [UIColor whiteColor];
    foodTreeLabel.backgroundColor = [UIColor clearColor];
    [self.foodTreeContainerView addSubview:foodTreeLabel];
    
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
    [self.favouritesGridView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contentSizeForViewInPopover = CGSizeMake(1000, 600);
    
    UIImage * backgroundPattern = [UIImage imageNamed:@"grey-bg.png"];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:backgroundPattern]];  
}

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView
{
    int count;
    
    if (aGridView == self.foodTreeGridView) {
        count = [foodTreeItems count];
    } else if (aGridView == self.favouritesGridView) {
        count = [favouriteItems count];
    }
    
    return count;
}

- (AQGridViewCell *) gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index
{    
    static NSString *PlainCellIdentifier = @"PlainCellIdentifier";
    GridViewCell *cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:PlainCellIdentifier];       
    
    if (aGridView == self.foodTreeGridView) {
        if (cell == nil) {
            cell = [[GridViewCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 160, 123) reuseIdentifier:PlainCellIdentifier];
        }
        
        TreeItem *item = [foodTreeItems objectAtIndex:index];
        [cell.imageView setImage:item.image];
        [cell.captionLabel setText:item.caption];
    }
    
    if (aGridView == self.favouritesGridView) {
        if (favouriteItems != nil) {
            if (cell == nil) {
                cell = [[GridViewCell alloc] initWithFrame:CGRectMake(0, 0, 160, 123) reuseIdentifier:PlainCellIdentifier];
            }
            
            NSString *item = [favouriteItems objectAtIndex:index];
            
            NSString *imageName = [[[[favouriteItems objectAtIndex:index] lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"-"] stringByAppendingPathExtension:@"jpg"];
            
            [cell.imageView setImage:[UIImage imageNamed:imageName]];
            [cell.captionLabel setText:item];
        }
    }    
    
    return cell;
}

- (CGSize) portraitGridCellSizeForGridView:(AQGridView *)aGridView
{
     return ( CGSizeMake(160.0, 123) );
}

-(void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index
{
    TreeItem *selectedItem = [[TreeItem alloc] init];
    
    if (gridView == self.favouritesGridView) {
        selectedItem = [favouriteItems objectAtIndex:index];
    }
    
    if (gridView == self.foodTreeGridView) {
        selectedItem = [foodTreeItems objectAtIndex:index];
        
    }
    
    // Create the view controller and initialize it with the
    // next level of data.
    FoodTreeViewController *viewController = [[FoodTreeViewController alloc]
                                              initWithData:[selectedItem caption]];
    
    viewController.selectedMeal = self.selectedMeal;
    
    self.foodTreeItems = [tree getItems:[selectedItem caption]];
    
    if (self.foodTreeItems == nil) {
        
        ItemViewController *itemViewController = [[ItemViewController alloc] init];
        
        itemViewController.delegate = self;
        
        itemViewController.managedObjectContext = self.managedObjectContext;
        
        itemViewController.selectedItem = selectedItem;
        
        itemViewController.selectedMeal = self.selectedMeal;
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dismissItemModal
{    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [delegate dismissMainPopover];
    
    
}

- (void)setupFetchedResultsController:(NSString *)meal
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Diary"; // Put your entity name here
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter it if you want
    request.predicate = [NSPredicate predicateWithFormat:@"%K like %@", @"meal", meal];
    
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
