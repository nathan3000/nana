//
//  MealSelectionViewController.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 23/02/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import "MealSelectionViewController.h"

@interface MealSelectionViewController ()

@end

@implementation MealSelectionViewController

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
    
    [self.buttonBlock.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [self.buttonBlock.layer setBorderWidth:1.0f];
    [self.buttonBlock.layer setCornerRadius:10.0f];
    

    NSArray *arrayOfButtons = [[NSArray alloc] initWithObjects:self.breakfastButton, self.lunchButton, self.dinnerButton, self.snacksButton, nil];
    
    NSString *color;
    
    for (UIButton *button in arrayOfButtons) {
        if ([button.currentTitle isEqualToString:@"Breakfast"]) {
            color = @"blue";
        } else if ([button.currentTitle isEqualToString:@"Lunch"]) {
            color = @"green2";
        } else if ([button.currentTitle isEqualToString:@"Dinner"]) {
            color = @"orange2";
        } else if ([button.currentTitle isEqualToString:@"Other"]) {
            color = @"purple";
        }
        
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:24]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button.titleLabel setShadowColor:[UIColor blackColor]];
        [button.titleLabel setShadowOffset:CGSizeMake(0.0, -1.0)];
        UIImage *buttonImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@Button.png", color]] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        UIImage *buttonImageHighlight = [[UIImage imageNamed:[NSString stringWithFormat:@"%@ButtonHighlight.png", color]] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIButton *)sender
{
    diaryController = [segue destinationViewController];
    [diaryController setSelectedMeal:[sender currentTitle]];
    [diaryController setManagedObjectContext:self.managedObjectContext];
    [diaryController setDelegate:self];
}

- (void)back
{
    [diaryController dismissModalViewControllerAnimated:YES];
}

- (void)finishedMeal
{
    [diaryController dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setButtonBlock:nil];
    [super viewDidUnload];
}
@end
