//
//  ItemViewController.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 19/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "ItemViewController.h"

@interface ItemViewController ()

@end

@implementation ItemViewController

@synthesize managedObjectContext = _managedObjectContext;

@synthesize selectedItem;

@synthesize delegate = _delegate;

@synthesize stepperValueLabel = _stepperValueLabel;

@synthesize gridView = _gridView;

@synthesize options = _options;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];    
    
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(230, 40, 400, 100)];
    [label setText:selectedItem.name];
    [label setFont:[UIFont systemFontOfSize:60]];
    [self.view addSubview:label];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 200, 150)];
    [image setImage:[UIImage imageNamed:selectedItem.image]];
    [self.view addSubview:image];
    
    UIView *sectionContainer = [[UIView alloc] initWithFrame:CGRectMake(40, 180, 720, 500)];
    [self.view addSubview:sectionContainer];
    
    int count = 0;
    
    self.options = [[NSMutableDictionary alloc] init];
    
    for (NSDictionary *dictionary in selectedItem.builder) {
        UIView *section = [[UIView alloc] initWithFrame:CGRectMake(0, 0+(count*220), 720, 200)];
        [section setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_jean"]]];
        [section.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [section.layer setBorderWidth:1.0f];
        [section.layer setCornerRadius:10.0f];
        [sectionContainer addSubview:section];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 720, 40)];
        [label setText:[dictionary objectForKey:@"question"]];
        [label setTextColor:[UIColor colorWithRed:30/255.0f green:30/255.0f blue:30/255.0f alpha:1.0f]];
        [label setFont:[UIFont systemFontOfSize:35]];
        [label setBackgroundColor:[UIColor clearColor]];
        [section addSubview:label];
        
        AQGridView *optionsGridView = [[AQGridView alloc] initWithFrame:CGRectMake(10, 60, 720, 123)];
        
        [optionsGridView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [optionsGridView setAutoresizesSubviews:YES];
        [optionsGridView setDelegate:self];
        [optionsGridView setDataSource:self];
        
        NSArray *array = [[NSArray alloc] initWithArray:[dictionary objectForKey:@"options"]];
        
        [self.options setObject:array forKey:[NSValue valueWithNonretainedObject:optionsGridView]];
        
        //[self.options setObject:@"rawr" forKey:@"rawr"];
                                
        [section addSubview:optionsGridView];         
        
        [optionsGridView reloadData];            
        
        count += 1;
    }
    
    UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(350, 620, 100, 58)];
    [addButton setTitle:@"Add" forState:UIControlStateNormal];
    [addButton.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
    [addButton.titleLabel setShadowColor:[UIColor blackColor]];
    [addButton.titleLabel setShadowOffset:CGSizeMake(-1.0, -1.0)];
    UIImage *buttonImage = [[UIImage imageNamed:@"greenButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"greenButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    [addButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [addButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [addButton addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    

    self.selectedOptions = [[NSMutableDictionary alloc] init];
        
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ok
{
    NSMutableArray *options = [[NSMutableArray alloc] init];
    for (id key in self.selectedOptions) {
        [options addObject:[self.selectedOptions objectForKey:key]];
    }
    
    [Helpers addItemToDiary:selectedItem withOptions:options forMeal:self.selectedMeal withContext:self.managedObjectContext];
    
    [self.delegate dismissItemModal];
}

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView
{
    return [[self.options objectForKey:[NSValue valueWithNonretainedObject:aGridView]] count];
}

- (AQGridViewCell *)gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index
{
    static NSString *PlainCellIdentifier = @"PlainCellIdentifier";
    GridViewCell *cell = (GridViewCell *)[aGridView dequeueReusableCellWithIdentifier:PlainCellIdentifier];
    
    if (cell == nil) {
        cell = [[GridViewCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 160, 123) reuseIdentifier:PlainCellIdentifier scale:1];
    }
    
    [cell setSelectionGlowColor:[UIColor greenColor]];
    [cell setSelectionGlowShadowRadius:1];
    
    NSArray *options = [self.options objectForKey:[NSValue valueWithNonretainedObject:aGridView]];
    
    NSString *itemName = [options objectAtIndex:index];
    
    Item *item = [self fetch:@"FoodTreeItem" withPredicate:[NSPredicate predicateWithFormat:@"name like %@", itemName]];
    
    if (item != nil) {
        [cell.imageView setImage:[UIImage imageNamed:item.image]];
        [cell.captionLabel setText:item.name];

    } else {
        if ([itemName isEqualToString:@"Yes"]) {
            [cell.imageView setImage:[UIImage imageNamed:@"yes.jpg"]];
        } else if ([itemName isEqualToString:@"No"]) {
            [cell.imageView setImage:[UIImage imageNamed:@"no.jpg"]];
        } else {
            [cell.imageView setImage:[UIImage imageNamed:@"none2.jpg"]];
        }
        [cell.captionLabel setText:itemName];
    }
    
    if ([self.preselects containsObject:itemName]) {
        //[cell setSelected:YES];
        [aGridView selectItemAtIndex:index animated:YES scrollPosition:AQGridViewScrollPositionNone];
        [self.selectedOptions setObject:itemName forKey:[NSValue valueWithNonretainedObject:aGridView]];
    }
    
    return cell;
}

- (void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index
{
    NSArray *options = [self.options objectForKey:[NSValue valueWithNonretainedObject:gridView]];
    NSString *itemName = [options objectAtIndex:index];
    [self.selectedOptions setObject:itemName forKey:[NSValue valueWithNonretainedObject:gridView]];
}

- (CGSize)portraitGridCellSizeForGridView:(AQGridView *)aGridView
{
    return ( CGSizeMake(160.0, 123) );
}

- (id)fetch:(NSString *)entityName withPredicate:(NSPredicate *)predicate {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.predicate = predicate;
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    NSError *error;
    NSArray *result = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (result != nil && [result count]) {
        return [result objectAtIndex:0];
    }    
    return nil;
}


@end
