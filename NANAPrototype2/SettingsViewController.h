//
//  SettingsViewController.h
//  NANAPrototype2
//
//  Created by Nathan Fisher on 19/02/2013.
//  Copyright (c) 2013 Nathan Fisher. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

#import "DiaryEntry.h"

@interface SettingsViewController : UITableViewController

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property BOOL debug;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)cancel:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *userIdLabel;

@end
