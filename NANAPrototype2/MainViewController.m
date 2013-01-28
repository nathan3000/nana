//
//  ViewController.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize fetchedResultsController = _fetchedResultsController;

@synthesize managedObjectContext = _managedObjectContext;

@synthesize mealPicker = _mealPicker;

@synthesize mealPickerPopover = _mealPickerPopover;

@synthesize foodTreeModal = _foodTreeModal;

@synthesize foodTreeViewController = _foodTreeViewController;

@synthesize diaryTableView;

@synthesize favouritesView, favouritesGridView;

@synthesize favouriteItems;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //self.favouritesView.layer.backgroundColor = [UIColor colorWithRed:233/255.0f green:237/255.0f blue:251/255.0f alpha:1.0f].CGColor;
    self.favouritesView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_jean"]];
    self.favouritesView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.favouritesView.layer.borderWidth = 1.0f;
    self.favouritesView.layer.cornerRadius = 10.0f;
    //self.favouritesView.layer.shadowColor = [UIColor blackColor].CGColor;
    //self.favouritesView.layer.shadowOpacity = 0.4;
    //self.favouritesView.layer.shadowRadius = 3.0;
    //self.favouritesView.layer.shadowOffset = CGSizeMake(2.0, 2.0);
    
    UILabel *favouritesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 400, 30)];
    [favouritesLabel setText:@"Tap items to add to food diary"];
    favouritesLabel.font = [UIFont systemFontOfSize:23];
    favouritesLabel.textColor = [UIColor blackColor];
    favouritesLabel.backgroundColor = [UIColor clearColor];
    [self.favouritesView addSubview:favouritesLabel];
    
    self.favouritesGridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 50, self.favouritesView.bounds.size.width, 400)];
    self.favouritesGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.favouritesGridView.autoresizesSubviews = YES;
    self.favouritesGridView.delegate = self;
    self.favouritesGridView.dataSource = self;    
    
    [self.favouritesView addSubview:self.favouritesGridView];
    
    UIButton *moreItemsButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 450, 475, 50)];
    [moreItemsButton setTitle:@"Find More Items" forState:UIControlStateNormal];
    [moreItemsButton.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [moreItemsButton.titleLabel setShadowColor:[UIColor blackColor]];
    [moreItemsButton.titleLabel setShadowOffset:CGSizeMake(1.0, 1.0)];    
    UIImage *buttonImage = [[UIImage imageNamed:@"greenButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"greenButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];    
    [moreItemsButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [moreItemsButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [moreItemsButton addTarget:self action:@selector(displayFoodTree:) forControlEvents:UIControlEventTouchUpInside];    
    
    [self.favouritesView addSubview:moreItemsButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
    if (favouriteItems == nil) {
        self.favouriteItems = [[NSMutableArray alloc] init];
        [self.favouriteItems addObjectsFromArray:[[NSSet setWithArray:[[self.fetchedResultsController fetchedObjects] valueForKey:@"label"]] allObjects]];
    }
    
    [self.favouritesGridView reloadData];    
}

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView
{
    return[favouriteItems count];
}

- (AQGridViewCell *) gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index
{
    static NSString *PlainCellIdentifier = @"PlainCellIdentifier";
    GridViewCell *cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:PlainCellIdentifier];
    
    if (cell == nil) {
        cell = [[GridViewCell alloc] initWithFrame:CGRectMake(0, 0, 160, 123) reuseIdentifier:PlainCellIdentifier];
    }
    
    NSString *item = [favouriteItems objectAtIndex:index];
    
    NSString *imageName = [[[[favouriteItems objectAtIndex:index] lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"-"] stringByAppendingPathExtension:@"jpg"];
    
    [cell.imageView setImage:[UIImage imageNamed:imageName]];
    [cell.captionLabel setText:item];
    
    
    return cell;
}

-(void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index
{
    NSString *selectedItem = [favouriteItems objectAtIndex:index];
    
    NSString *selectedMeal = @"Breakfast";
    
    NSLog(@"Adding %@ to food diary for %@", selectedItem, selectedMeal);
    
    Diary *diary = [NSEntityDescription insertNewObjectForEntityForName:@"Diary"
                                                 inManagedObjectContext:self.managedObjectContext];
    
    diary.label = selectedItem;
    
    diary.meal = selectedMeal;
    
    [self.managedObjectContext save:nil]; // write to database
    
    [self performFetch];
    [self.diaryTableView reloadData];
}

- (CGSize) portraitGridCellSizeForGridView:(AQGridView *)aGridView
{
    return ( CGSizeMake(160.0, 123) );
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}


- (IBAction)addItem:(id)sender
{
    if (_mealPicker == nil) {
        self.mealPicker = [[MealPickerViewController alloc] init];        
        _mealPicker.delegate = self;
        _mealPicker.managedObjectContext = self.managedObjectContext;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_mealPicker];
        self.mealPickerPopover = [[UIPopoverController alloc] initWithContentViewController:navigationController];
    }
    
    [self.mealPickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}

- (void)displayFoodTree:(id)sender
{
    self.foodTreeViewController = [[FoodTreeViewController alloc] init];
    
    self.foodTreeViewController.delegate = self;
    
    self.foodTreeViewController.managedObjectContext = self.managedObjectContext;
    
    self.foodTreeModal = [[UINavigationController alloc] initWithRootViewController:_foodTreeViewController];
    
    self.foodTreeModal.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:self.foodTreeModal animated:YES completion:nil];
}

- (void)dismissModal
{
    [self dismissViewControllerAnimated:YES completion:nil];   
}

- (void)dismissMainPopover
{    
    [self dismissViewControllerAnimated:YES completion:nil];    
    [self performFetch];
    [self.diaryTableView reloadData];
}

#pragma mark - 
#pragma mark Food Diary Table
- (void)setupFetchedResultsController
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Diary"; // Put your entity name here
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter it if you want
    //request.predicate = [NSPredicate predicateWithFormat:@"Role.name = Blah"];
    
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
   /* if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }*/
    
    [self configureCell:cell atIndexPath:indexPath];    
            
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.diaryTableView beginUpdates]; // Avoid  NSInternalInconsistencyException
        
        // Delete the role object that was swiped
        Diary *itemToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
        NSLog(@"Deleting (%@)", itemToDelete.label);
        [self.managedObjectContext deleteObject:itemToDelete];
        [self.managedObjectContext save:nil];
        
        // Delete the (now empty) row on the table
        [self.diaryTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self performFetch];
        
        [self.diaryTableView endUpdates];
    }
}
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{   
    
    // configure your cell here..
    
    // check for no entries..
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    if([sectionInfo numberOfObjects] != 0)
    {
        
        Diary *diary = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        if (diary != nil) {
            UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
            nameLabel.text = diary.label;
            UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
            
            NSString *imageName = [[[diary.label lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"-"] stringByAppendingPathExtension:@"jpg"];
            imageView.image = [UIImage imageNamed:imageName];
        }
        
    }

}

@end
