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

@synthesize foodTreeModal = _foodTreeModal;

@synthesize foodTreeViewController = _foodTreeViewController;

@synthesize diaryTableView;

@synthesize favouritesView, favouritesGridView;

@synthesize favouriteItems;

@synthesize selectedMeal = _selectedMeal;

@synthesize diaryView = _diaryView;

@synthesize diaryTitleLabel = _diaryTitleLabel;

@synthesize finishedMeals = _finishedMeals;

@synthesize foodTreeButton = _foodTreeButton;

@synthesize color = _color;

@synthesize delegate = _delegate;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // Style change meal button
    [self.changeMealButton.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [self.changeMealButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.changeMealButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.changeMealButton.titleLabel setShadowColor:[UIColor blackColor]];
    [self.changeMealButton.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];
   

    [self.changeMealButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    // Setup diary view
    [self.diaryView setBackgroundColor:[UIColor clearColor]];
    
    // Create diary title label
    self.diaryTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 400, 30)];
    [self.diaryTitleLabel setFont:[UIFont systemFontOfSize:23]];
    [self.diaryTitleLabel setTextColor:[UIColor blackColor]];
    [self.diaryTitleLabel setBackgroundColor:[UIColor clearColor]];    
    [self.diaryView addSubview:self.diaryTitleLabel];
    
    
    [self.finishedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.finishedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    
    [self.finishedButton.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [self.finishedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.finishedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [self.finishedButton.titleLabel setShadowColor:[UIColor blackColor]];
    [self.finishedButton.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];
   
   
    [self.finishedButton addTarget:self action:@selector(finished:) forControlEvents:UIControlEventTouchUpInside];
    [self.finishedButton setEnabled:NO];
    
    
    // End diary view setup
    
    // Setup favourites view
    [self.favouritesView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_jean"]]];
    [self.favouritesView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.favouritesView.layer setBorderWidth:1.0f];
    [self.favouritesView.layer setCornerRadius:10.0f];
    
    // Create favourites title label
    UILabel *favouritesLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 400, 30)];
    [favouritesLabel setText:@"Tap items to add to food diary"];
    [favouritesLabel setFont:[UIFont systemFontOfSize:23]];
    [favouritesLabel setTextColor:[UIColor blackColor]];
    [favouritesLabel setBackgroundColor:[UIColor clearColor]];    
    
    // Initialize grid view to display favourite items
    self.favouritesGridView = [[AQGridView alloc] initWithFrame:CGRectMake(0, 50, self.favouritesView.bounds.size.width, 400)];
    [self.favouritesGridView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    [self.favouritesGridView setAutoresizesSubviews:YES];
    [self.favouritesGridView setDelegate:self];
    [self.favouritesGridView setDataSource:self];    
    
    // Create 'Find More Items' button
    self.foodTreeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 440, 475, 60)];
    [self.foodTreeButton setTitle:@"Find More Items" forState:UIControlStateNormal];
    [self.foodTreeButton.titleLabel setFont:[UIFont systemFontOfSize:30]];
    [self.foodTreeButton.titleLabel setShadowColor:[UIColor grayColor]];
    [self.foodTreeButton.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];
    UIImage *buttonImage = [[UIImage imageNamed:@"greenButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"greenButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];    
    [self.foodTreeButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.foodTreeButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [self.foodTreeButton addTarget:self action:@selector(displayFoodTree:) forControlEvents:UIControlEventTouchUpInside];    
    
    // Add elements to favourites view
    [self.favouritesView addSubview:favouritesLabel];
    [self.favouritesView addSubview:self.favouritesGridView];
    [self.favouritesView addSubview:self.foodTreeButton];
    
    // End favourites view setup
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDate *now = [NSDate date];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"mealStartTime"] == nil) {
        [[NSUserDefaults standardUserDefaults] setObject:now forKey:@"mealStartTime"];
    }    
    
    if ([self.selectedMeal isEqualToString:@"Breakfast"]) {
        self.color = @"blue";
    } else if ([self.selectedMeal isEqualToString:@"Lunch"]) {
        self.color = @"green2";
    } else if ([self.selectedMeal isEqualToString:@"Dinner"]) {
        self.color = @"orange2";
    } else if ([self.selectedMeal isEqualToString:@"Snacks"]) {
        self.color = @"purple";
    }    
    
    NSMutableAttributedString *mealTitleString;
    mealTitleString = [[NSMutableAttributedString alloc] initWithString:self.selectedMeal];
    [mealTitleString addAttribute:NSKernAttributeName value:[NSNumber numberWithInt:-3] range:NSMakeRange(0, self.selectedMeal.length)];
    [mealTitleString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:60] range:NSMakeRange(0, self.selectedMeal.length)];
    [mealTitleString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, self.selectedMeal.length)];
    [self.mealTitle setAttributedText:mealTitleString];
    [self.mealTitle setShadowColor:[UIColor grayColor]];
    [self.mealTitle setShadowOffset:CGSizeMake(0.0, -1.0)];
    //[self.diaryTitleLabel setText:[NSString stringWithFormat:@"So far for %@ you've had...", self.selectedMeal]];
    
    [self.diaryTopBorder setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@Bar.png", self.color]]]];

    UIImage *changeMealButtonImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@Button.png", self.color]] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *changeMealButtonImageHighlight = [[UIImage imageNamed:[NSString stringWithFormat:@"%@ButtonHighlight.png", self.color]] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [self.changeMealButton setBackgroundImage:changeMealButtonImage forState:UIControlStateNormal];
    [self.changeMealButton setBackgroundImage:changeMealButtonImageHighlight forState:UIControlStateHighlighted];
    
    UIImage *finishedButtonImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@Button.png", self.color]] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *finishedButtonImageHighlight = [[UIImage imageNamed:[NSString stringWithFormat:@"%@ButtonHighlight.png", self.color]] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [self.finishedButton setBackgroundImage:finishedButtonImage forState:UIControlStateNormal];
    [self.finishedButton setBackgroundImage:finishedButtonImageHighlight forState:UIControlStateHighlighted];
            
    [self setupFetchedResultsController:self.selectedMeal];
    
    [self refreshDiary];    
}

- (void)back
{
    // Delete all items in current meal.    
    for (NSManagedObject *object in [self.fetchedResultsController fetchedObjects]) {
        [self.managedObjectContext deleteObject:object];
    }
    
    // Set mealStartTime to nil.
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:@"mealStartTime"];
    
    // Call back method in delegate to dismiss modal.
    [self.delegate back];
}

- (void)refreshDiary
{
    [self performFetch];
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:0];
    if([sectionInfo numberOfObjects] == 0)
    {
        UIImageView *overlayDiaryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlayDiaryHelp.png"]];
        [overlayDiaryView setFrame:CGRectMake(0, 40, 460, 532)];
        [overlayDiaryView setTag:200];
        [self.diaryView addSubview:overlayDiaryView];
        [self.diaryView bringSubviewToFront:overlayDiaryView];
        [self.finishedButton setEnabled:NO];
    } else {
        [self.foodTreeButton setTitle:@"Find More Items" forState:UIControlStateNormal];
        [Helpers removeSubviewFrom:self.diaryView withTag:200];
        [Helpers removeSubviewFrom:self.favouritesView withTag:201];
        
        [self.finishedButton setEnabled:YES];
    }
    
    [self computeFavourites:self.selectedMeal];
    
    if (self.favouriteItems == nil) {
        UIImageView *overlayFavouritesView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"overlayFavouritesHelp.png"]];
        [overlayFavouritesView setFrame:CGRectMake(80, 150, 289, 109)];
        [overlayFavouritesView setTag:201];
        [self.favouritesView addSubview:overlayFavouritesView];
        [self.favouritesView bringSubviewToFront:overlayFavouritesView];
        
        [self.foodTreeButton setTitle:@"Add Items" forState:UIControlStateNormal];
    } 
    
    
    [self.diaryTableView reloadData];
    [self.favouritesGridView reloadData];
    
    [self scrollToBottomOfTableView:self.diaryTableView];
}

- (UIViewController *)presentModalViewControllerWithIdentifier:(NSString *)identifier
                                                        andSize:(CGSize)size
                                        andModalTransitionStyle:(UIModalTransitionStyle)modalTransitionStyle {
    ModalViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    viewController.delegate = self;
    
    viewController.modalPresentationStyle = UIModalPresentationPageSheet;
    viewController.modalTransitionStyle = modalTransitionStyle;
    [self presentViewController:viewController animated:YES completion:nil];
    viewController.view.superview.autoresizingMask =
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin |
    UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    viewController.view.superview.frame = CGRectMake(0, 0, size.width, size.height);
    CGPoint center = CGPointMake(CGRectGetMidX(screenBounds), CGRectGetMidY(screenBounds));
    viewController.view.superview.center = UIDeviceOrientationIsPortrait(self.interfaceOrientation) ? center : CGPointMake(center.y, center.x);
    
    return viewController;
}

- (void)scrollToBottomOfTableView:(UITableView *)aTableView;
{
    if (aTableView.contentSize.height > aTableView.bounds.size.height) {
        CGFloat offset = aTableView.contentSize.height - aTableView.bounds.size.height;
        [aTableView setContentOffset:CGPointMake(0, offset) animated:YES];
    }    
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
    
    DiaryEntry *diaryEntry = [favouriteItems objectAtIndex:index];
    
    NSString *imageName = [[[diaryEntry.item.name lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"-"] stringByAppendingPathExtension:@"jpg"];
    
    [cell.imageView setImage:[UIImage imageNamed:imageName]];
    [cell.captionLabel setText:diaryEntry.item.name];
    
    
    return cell;
}

-(void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index
{    
    DiaryEntry *diaryEntry = [favouriteItems objectAtIndex:index];
    
    [Helpers addItemToDiary:diaryEntry.item forMeal:self.selectedMeal withContext:self.managedObjectContext];
        
    [self refreshDiary];
    [gridView deselectItemAtIndex:index animated:YES];
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

- (void)displayFoodTree:(id)sender
{
    self.foodTreeViewController = [[FoodTreeViewController alloc] init];
    
    self.foodTreeViewController.delegate = self;
    
    self.foodTreeViewController.managedObjectContext = self.managedObjectContext;
    
    self.foodTreeViewController.selectedMeal = self.selectedMeal;
    
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
- (void)setupFetchedResultsController:(NSString *)mealType
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"DiaryEntry"; // Put your entity name here
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter it if you want
    request.predicate = [NSPredicate predicateWithFormat:@"meal.type like %@ AND meal.startTime == %@", mealType,[[NSUserDefaults standardUserDefaults] objectForKey:@"mealStartTime"]];
    
    // 4 - Sort it if you want
    request.sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"time"
                                                                                     ascending:YES]];
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
        DiaryEntry *itemToDelete = [self.fetchedResultsController objectAtIndexPath:indexPath];
       // NSLog(@"Deleting (%@)", itemToDelete.name);
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
        
        DiaryEntry *diaryEntry = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        if (diaryEntry != nil) {
            UILabel *nameLabel = (UILabel *)[cell viewWithTag:100];
            nameLabel.text = diaryEntry.item.name;
            UIImageView *imageView = (UIImageView *)[cell viewWithTag:101];
            
            NSString *imageName = [[[diaryEntry.item.name lowercaseString] stringByReplacingOccurrencesOfString:@" " withString:@"-"] stringByAppendingPathExtension:@"jpg"];
            imageView.image = [UIImage imageNamed:imageName];
        }
        
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Settings"]) {
        SettingsViewController *viewController = [segue destinationViewController];
        viewController.managedObjectContext = self.managedObjectContext;
    }
    
}

- (void)dismissMealSelectionModal:(NSString *)meal
{
    //self.selectedMeal = meal;
    
       
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self viewWillAppear:YES];
}


- (BOOL)takePicture {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    // Displays a control that allows the user to choose picture or
    // movie capture, if both are available:
    cameraUI.mediaTypes =
    [UIImagePickerController availableMediaTypesForSourceType:
     UIImagePickerControllerSourceTypeCamera];
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    cameraUI.delegate = self;
    
    [self presentModalViewController: cameraUI animated: YES];
    return YES;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:NO completion:nil];
    [self processImage:info];
    [self.delegate finishedMeal];
}

// REFERENCE TO STACKOVERFLOW
// http://stackoverflow.com/questions/8409461/why-wont-dismissmodalviewcontrolleranimated-dismiss-uiimagepickercontroller-imm

-(void)processImage:(NSDictionary *)info {    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // processing of image here on background thread
        
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *imageData = UIImageJPEGRepresentation(image, 0.8);
        
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"startTime == %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"mealStartTime"]];
        [request setPredicate:predicate];
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Meal" inManagedObjectContext:self.managedObjectContext];
        [request setEntity:entity];
        
        NSError *errorFetch = nil;
        NSArray *results = [self.managedObjectContext executeFetchRequest:request error:&errorFetch];
        
        Meal *meal = [results objectAtIndex:0];
        meal.image = imageData;
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // update UI here on main thread
                    
        });
    });
}

- (void)finished:(UIButton *)button
{
    [self takePicture];
}

- (void)computeFavourites:(NSString *)selectedMeal
{
    self.favouriteItems = [[NSMutableArray alloc] init];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"meal.type like %@", selectedMeal];
    fetchRequest.fetchLimit = 9;
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"DiaryEntry" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *fetchedObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    self.favouriteItems = [[NSMutableArray alloc] init];
    
    NSMutableArray *namesOfFavourites = [[NSMutableArray alloc] init];
    
    // If an object with the same name is not already in the favourites list, then add to favourites list
    for (NSObject *fetchedObject in fetchedObjects) {
        NSString *name = [[fetchedObject valueForKey:@"item"] valueForKey:@"name"];
        if (![namesOfFavourites containsObject:name]) {
            [self.favouriteItems addObject:fetchedObject];
            [namesOfFavourites addObject:name];
        }
    }
}

- (void)viewDidUnload {
    [self setMealTitle:nil];
    [self setDiaryTopBorder:nil];
    [super viewDidUnload];
}
@end
