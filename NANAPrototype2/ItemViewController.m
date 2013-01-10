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

@synthesize delegate;

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
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(140, 40, 400, 50)];
    [label setText:[selectedItem caption]];
    [label setFont:[UIFont systemFontOfSize:40]];
    [self.view addSubview:label];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(40, 100, 454, 307)];              
    [image setImage:[selectedItem image]];
    [self.view addSubview:image];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(ok)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"OK" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(220, 500, 100, 70)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:20]];
    [self.view addSubview:button];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ok
{
    NSLog(@"Adding item to food diary");
    
    Diary *diary = [NSEntityDescription insertNewObjectForEntityForName:@"Diary"
                                                 inManagedObjectContext:self.managedObjectContext];
    
    diary.label = self.selectedItem.caption;
    
    [self.managedObjectContext save:nil]; // write to database    
    
    [delegate dismissItemModal];
}

@end
