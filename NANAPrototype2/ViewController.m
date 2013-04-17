//
//  ViewController.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 11/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize mealPicker = _mealPicker;

@synthesize mealPickerPopover = _mealPickerPopover;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
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
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:_mealPicker];
        self.mealPickerPopover = [[UIPopoverController alloc] initWithContentViewController:navigationController];
    }
    
    [self.mealPickerPopover presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:UIPopoverArrowDirectionUp animated:YES];
}
@end
