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
    
    if ([selectedItem.name isEqualToString:@"Tea"]) {
        
        UIView *section1 = [[UIView alloc] initWithFrame:CGRectMake(40, 180, 420, 100)];        
        [section1 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_jean"]]];
        [section1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [section1.layer setBorderWidth:1.0f];
        [section1.layer setCornerRadius:10.0f];        
        [self.view addSubview:section1];
        
        UILabel *milkLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 420, 30)];
        [milkLabel setText:@"Did you have milk?"];
        [milkLabel setTextColor:[UIColor colorWithRed:30/255.0f green:30/255.0f blue:30/255.0f alpha:1.0f]];
        [milkLabel setFont:[UIFont systemFontOfSize:24]];
        [milkLabel setBackgroundColor:[UIColor clearColor]];
        [section1 addSubview:milkLabel];
        
        UIButton *yesButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 50, 100, 40)];
        [yesButton setTitle:@"Yes" forState:UIControlStateNormal];
        [yesButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        [yesButton.titleLabel setFont:[UIFont systemFontOfSize:24]];
        [yesButton setTitleColor:[UIColor colorWithRed:30/255.0f green:30/255.0f blue:30/255.0f alpha:1.0f] forState:UIControlStateNormal];
        UIImage *yesButtonImage = [[UIImage imageNamed:@"whiteButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        UIImage *yesButtonImageHighlight = [[UIImage imageNamed:@"whiteButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        [yesButton setBackgroundImage:yesButtonImage forState:UIControlStateNormal];
        [yesButton setBackgroundImage:yesButtonImageHighlight forState:UIControlStateHighlighted];
        [yesButton addTarget:self action:@selector(toggleCheckbox:) forControlEvents:UIControlEventTouchUpInside];
        UIView *checkbox1 = [[UIView alloc] initWithFrame:CGRectMake(8, 7, 26, 26)];
        [checkbox1 setBackgroundColor:[UIColor whiteColor]];
        [checkbox1.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [checkbox1.layer setBorderWidth:1.0f];
        [checkbox1.layer setCornerRadius:5.0f];
        [yesButton addSubview:checkbox1];
        /*
        UIImageView *buttonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unchecked_checkbox.png"]];
        [buttonImageView setFrame:CGRectMake(8, 7, 26, 26)];
        //[buttonImageView setTag:300];
        [yesButton addSubview:buttonImageView];
         */
        [section1 addSubview:yesButton];
        
        UIButton *noButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 50, 100, 40)];
        [noButton setTitle:@"No" forState:UIControlStateNormal];
        [noButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 25, 0, 0)];
        [noButton.titleLabel setFont:[UIFont systemFontOfSize:24]];
        [noButton setTitleColor:[UIColor colorWithRed:30/255.0f green:30/255.0f blue:30/255.0f alpha:1.0f] forState:UIControlStateNormal];
        UIImage *noButtonImage = [[UIImage imageNamed:@"whiteButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        UIImage *noButtonImageHighlight = [[UIImage imageNamed:@"whiteButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        [noButton setBackgroundImage:noButtonImage forState:UIControlStateNormal];
        [noButton setBackgroundImage:noButtonImageHighlight forState:UIControlStateHighlighted];
        [noButton addTarget:self action:@selector(toggleCheckbox:) forControlEvents:UIControlEventTouchUpInside];
        UIView *checkbox2 = [[UIView alloc] initWithFrame:CGRectMake(8, 7, 26, 26)];
        [checkbox2 setBackgroundColor:[UIColor whiteColor]];
        [checkbox2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [checkbox2.layer setBorderWidth:1.0f];
        [checkbox2.layer setCornerRadius:5.0f];
        [noButton addSubview:checkbox2];
        /*
        UIImageView *noButtonImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"unchecked_checkbox.png"]];
        [noButtonImageView setFrame:CGRectMake(8, 7, 26, 26)];
        //[noButtonImageView setTag:301];
        [noButton addSubview:noButtonImageView];
         */
        [section1 addSubview:noButton];

        
        UIView *section2 = [[UIView alloc] initWithFrame:CGRectMake(40, 300, 420, 130)];
        [section2 setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"gray_jean"]]];
        [section2.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [section2.layer setBorderWidth:1.0f];
        [section2.layer setCornerRadius:10.0f];
        [self.view addSubview:section2];
        
        
        UILabel *sugarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 420, 30)];
        [sugarLabel setText:@"How many sugars?"];
        [sugarLabel setTextColor:[UIColor colorWithRed:30/255.0f green:30/255.0f blue:30/255.0f alpha:1.0f]];
        [sugarLabel setFont:[UIFont systemFontOfSize:24]];
        [sugarLabel setBackgroundColor:[UIColor clearColor]];
        [section2 addSubview:sugarLabel];        
        
        UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(220, 65, 20, 0)];
        [stepper addTarget:self action:@selector(stepperChanged:) forControlEvents:UIControlEventValueChanged];
        [section2 addSubview:stepper];
        
        self.stepperValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 100, 60)];
        [self.stepperValueLabel setBackgroundColor:[UIColor whiteColor]];        
        [self.stepperValueLabel.layer setBorderColor:[UIColor lightGrayColor].CGColor];
        [self.stepperValueLabel.layer setBorderWidth:1.0f];
        [self.stepperValueLabel.layer setCornerRadius:5.0f];
        double stepperValue = stepper.value;
        self.stepperValueLabel.text = [NSString stringWithFormat:@" %.f", stepperValue];
        [self.stepperValueLabel setFont:[UIFont systemFontOfSize:50]];
        [section2 addSubview:self.stepperValueLabel];

    
        UIButton *addButton = [[UIButton alloc] initWithFrame:CGRectMake(190, 440, 100, 50)];
        [addButton setTitle:@"Add" forState:UIControlStateNormal];
        [addButton.titleLabel setFont:[UIFont systemFontOfSize:24]];
        [addButton.titleLabel setShadowColor:[UIColor blackColor]];
        [addButton.titleLabel setShadowOffset:CGSizeMake(1.0, 1.0)];
        UIImage *buttonImage = [[UIImage imageNamed:@"greenButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        UIImage *buttonImageHighlight = [[UIImage imageNamed:@"greenButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
        [addButton setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [addButton setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
        [addButton addTarget:self action:@selector(ok) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:addButton];


        
        /*
        
        
        UILabel *milkLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 200, 30)];
        [milkLabel setText:@"Milk?"];
        [milkLabel setFont:[UIFont systemFontOfSize:20]];
        [self.view addSubview:milkLabel];
        
        UISwitch *switcher = [[UISwitch alloc] initWithFrame:CGRectMake(250, 150, 20, 10)];
        [self.view addSubview:switcher];

        UILabel *sugarsLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 190, 200, 30)];
        [sugarsLabel setText:@"How many sugars?"];
        [sugarsLabel setFont:[UIFont systemFontOfSize:20]];
        [self.view addSubview:sugarsLabel];
        
        UIStepper *stepper = [[UIStepper alloc] initWithFrame:CGRectMake(250, 190, 20, 10)];
        [self.view addSubview:stepper];
         
         */
    }
    

}

- (void)stepperChanged:(UIStepper *)stepper
{
    double stepperValue = stepper.value;
    self.stepperValueLabel.text = [NSString stringWithFormat:@" %.f", stepperValue];
}

- (void)toggleCheckbox:(UIButton *)button
{
    NSLog(@"hit toggleCheckbox");
    if ([button.titleLabel.text isEqual:@"Yes"]) {
        [Helpers removeSubviewFrom:self.view withTag:300];
        UIImageView *yesImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick.png"]];
        [yesImageView setFrame:CGRectMake(8, 7, 26, 26)];
        [yesImageView setTag:300];
        [button addSubview:yesImageView];
    } else if ([button.titleLabel.text isEqual:@"No"]) {
        [Helpers removeSubviewFrom:self.view withTag:300];
        UIImageView *noImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tick.png"]];
        [noImageView setFrame:CGRectMake(8, 7, 26, 26)];
        [noImageView setTag:300];
        [button addSubview:noImageView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ok
{
    [Helpers addItemToDiary:selectedItem forMeal:self.selectedMeal withContext:self.managedObjectContext];
    
    [self.delegate dismissItemModal];
}

@end
