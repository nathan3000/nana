//
//  MealPickerViewController.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 15/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "MealPickerViewController.h"

@interface MealPickerViewController ()

@end

@implementation MealPickerViewController

@synthesize delegate = _delegate;

@synthesize managedObjectContext = _managedObjectContext;

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
    
    self.contentSizeForViewInPopover = CGSizeMake(560.0, 110.0);
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBarHidden = YES;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    [label setText:@"Please select which meal:"];
    label.font = [UIFont systemFontOfSize:23];
    [self.view addSubview:label];
    
    [self.view addSubview:[self createButton:@"Breakfast" position:CGRectMake(10, 40, 100.0, 60.0)]];
    [self.view addSubview:[self createButton:@"Lunch" position:CGRectMake(120, 40, 100.0, 60.0)]];
    [self.view addSubview:[self createButton:@"Dinner" position:CGRectMake(230, 40, 100.0, 60.0)]];
    [self.view addSubview:[self createButton:@"Snacks" position:CGRectMake(340, 40, 100.0, 60.0)]];
    [self.view addSubview:[self createButton:@"Drinks" position:CGRectMake(450, 40, 100.0, 60.0)]];
    
}

- (UIButton *)createButton:(NSString *)label position:(CGRect)position
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self
               action:@selector(mealSelected:)
     forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:label forState:UIControlStateNormal];
    [button setFrame:position];
    
    return button;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) mealSelected:(id)sender
{    
    NSLog(@"meal selected %@", [sender currentTitle]);
    
    FoodTreeViewController *foodTreeViewController = [[FoodTreeViewController alloc] init];    
    
    foodTreeViewController.delegate = self.delegate;
    foodTreeViewController.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:foodTreeViewController animated:YES];
    
}

@end
