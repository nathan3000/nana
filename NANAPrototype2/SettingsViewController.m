//
//  SettingsViewController.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 19/02/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize fetchedResultsController = _fetchedResultsController;

@synthesize managedObjectContext = _managedObjectContext;

@synthesize debug = _debug;

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
      

    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    if (userId != nil) {
        self.userIdLabel.text = userId;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath section] == 0) {
        NSString *userId = [self generateRandomString:10];
        [[NSUserDefaults standardUserDefaults] setObject:userId forKey:@"userId"];
    
        self.userIdLabel.text = userId;        
    }
    
    if ([indexPath section] == 1) {
        [self sync];
    }
}

- (void)sync
{
    /*
    NSLog(@"Syncronizing data...");
    
    // Get data from core data.
    [self setupFetchedResultsController];
      
    // Loop through making PFObjects.
    
    NSError *error = nil;
    NSInteger syncCount = 0;
    
    for (Diary *item in [self.fetchedResultsController fetchedObjects]) {
        NSLog(@"Pushing %@ to cloud", item.label);
        
        PFObject *testObject = [PFObject objectWithClassName:@"Diary"];
        [testObject setObject:item.label forKey:@"label"];
        [testObject setObject:item.meal forKey:@"meal"];
        [testObject setObject:item.time forKey:@"time"];
        [testObject setObject:item.user forKey:@"user"];
        [testObject save:&error];
        syncCount += 1;
    }
    
    if (error == nil) {
        NSLog(@"Successfully synced data! %d objects", syncCount);
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!"
                                                        message:@"Data synced successfully."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:@"lastSyncTime"];
    } else {
        NSLog(@"Oops sync went wrong!");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:@"Oops sync went wrong!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupFetchedResultsController
{
    // 1 - Decide what Entity you want
    NSString *entityName = @"Diary"; // Put your entity name here
    
    // 2 - Request that Entity
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"lastSyncTime"] != nil) {
        // 3 - Filter it if you want
        NSLog(@"Filter by time.");
        request.predicate = [NSPredicate predicateWithFormat:@"time > %@", [[NSUserDefaults standardUserDefaults] objectForKey:@"lastSyncTime"]];
    }   
    
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

- (void)performFetch
{
    if (self.fetchedResultsController) {
        if (self.fetchedResultsController.fetchRequest.predicate) {
            if (self.debug) NSLog(@"[%@ %@] fetching %@ with predicate: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), self.fetchedResultsController.fetchRequest.entityName, self.fetchedResultsController.fetchRequest.predicate);
        } else {
            if (self.debug) NSLog(@"[%@ %@] fetching all %@ (i.e., no predicate)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), self.fetchedResultsController.fetchRequest.entityName);
        }
        NSError *error;
        [self.fetchedResultsController performFetch:&error];
        if (error) NSLog(@"[%@ %@] %@ (%@)", NSStringFromClass([self class]), NSStringFromSelector(_cmd), [error localizedDescription], [error localizedFailureReason]);
    } else {
        if (self.debug) NSLog(@"[%@ %@] no NSFetchedResultsController (yet?)", NSStringFromClass([self class]), NSStringFromSelector(_cmd));
    }
}


- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)generateRandomString:(int)length {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    NSMutableString *randomString = [NSMutableString stringWithCapacity: length];
    
    for (int i=0; i<length; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random() % [letters length]]];
    }
    
    return randomString;
}
@end
