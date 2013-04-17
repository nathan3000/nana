//
//  Tree.m
//  NANAPrototype2
//
//  Created by Nathan Fisher on 15/12/2012.
//  Copyright (c) 2012 Nathan Fisher. All rights reserved.
//

#import "Tree.h"

@interface Tree()

@end

@implementation Tree 

- (id)init
{
    self = [super init];
    
    if (self) {
        
        _tree = [[MultiValueDictionary alloc] init];
        
        TreeItem *drinks = [[TreeItem alloc] initWithCaption:@"Drinks" andImage:[UIImage imageNamed:@"drinks.jpg"]];
        TreeItem *bread = [[TreeItem alloc] initWithCaption:@"Bread" andImage:[UIImage imageNamed:@"bread.jpg"]];
        TreeItem *cereal = [[TreeItem alloc] initWithCaption:@"Cereal" andImage:[UIImage imageNamed:@"cereal.jpg"]];
        TreeItem *pasta = [[TreeItem alloc] initWithCaption:@"Pasta" andImage:[UIImage imageNamed:@"pasta.jpg"]];
        TreeItem *dairy = [[TreeItem alloc] initWithCaption:@"Dairy" andImage:[UIImage imageNamed:@"dairy.jpg"]];
        TreeItem *meat = [[TreeItem alloc] initWithCaption:@"Meat" andImage:[UIImage imageNamed:@"meat.jpg"]];
        TreeItem *fish = [[TreeItem alloc] initWithCaption:@"Fish" andImage:[UIImage imageNamed:@"fish.jpg"]];
        TreeItem *fruit = [[TreeItem alloc] initWithCaption:@"Fruit" andImage:[UIImage imageNamed:@"fruit.jpg"]];
        TreeItem *vegetables = [[TreeItem alloc] initWithCaption:@"Vegetables" andImage:[UIImage imageNamed:@"vegetables.jpg"]];
        TreeItem *desserts = [[TreeItem alloc] initWithCaption:@"Desserts" andImage:[UIImage imageNamed:@"desserts.jpg"]];
        TreeItem *savourySnacks = [[TreeItem alloc] initWithCaption:@"Savoury Snacks" andImage:[UIImage imageNamed:@"savoury-snacks.jpg"]];
        TreeItem *condiments = [[TreeItem alloc] initWithCaption:@"Condiments" andImage:[UIImage imageNamed:@"condiments.jpg"]];
        
        [_tree addObject:drinks forKey:@"root"];
        [_tree addObject:bread forKey:@"root"];
        [_tree addObject:cereal forKey:@"root"];
        [_tree addObject:pasta forKey:@"root"];
        [_tree addObject:dairy forKey:@"root"];
        [_tree addObject:meat forKey:@"root"];
        [_tree addObject:fish forKey:@"root"];
        [_tree addObject:fruit forKey:@"root"];
        [_tree addObject:vegetables forKey:@"root"];
        [_tree addObject:desserts forKey:@"root"];
        [_tree addObject:savourySnacks forKey:@"root"];
        [_tree addObject:condiments forKey:@"root"];
        
        
        TreeItem *tea = [[TreeItem alloc] initWithCaption:@"Tea" andImage:[UIImage imageNamed:@"tea.jpg"]];
        
        tea.details = YES;
        
        TreeItem *coffee = [[TreeItem alloc] initWithCaption:@"Coffee" andImage:[UIImage imageNamed:@"coffee.jpg"]];
        
        TreeItem *squash = [[TreeItem alloc] initWithCaption:@"Squash" andImage:[UIImage imageNamed:@"squash.jpg"]];
        
        TreeItem *cocoa = [[TreeItem alloc] initWithCaption:@"Cocoa" andImage:[UIImage imageNamed:@"cocoa.jpg"]];
        
        TreeItem *fizzy = [[TreeItem alloc] initWithCaption:@"Fizzy" andImage:[UIImage imageNamed:@"fizzy.jpg"]];
        
        TreeItem *alcohol = [[TreeItem alloc] initWithCaption:@"Alcohol" andImage:[UIImage imageNamed:@"alcohol.jpg"]];
        
        TreeItem *juices = [[TreeItem alloc] initWithCaption:@"Juices" andImage:[UIImage imageNamed:@"juices.jpg"]];
        
        TreeItem *milkShakes = [[TreeItem alloc] initWithCaption:@"Milk Shakes" andImage:[UIImage imageNamed:@"milk-shakes.jpg"]];
        
        TreeItem *water = [[TreeItem alloc] initWithCaption:@"Water" andImage:[UIImage imageNamed:@"water.jpg"]];
        
        TreeItem *milk = [[TreeItem alloc] initWithCaption:@"Milk" andImage:[UIImage imageNamed:@"milk.jpg"]];
        
        [_tree addObject:tea forKey:@"Drinks"];
        [_tree addObject:coffee forKey:@"Drinks"];
        [_tree addObject:squash forKey:@"Drinks"];
        [_tree addObject:cocoa forKey:@"Drinks"];
        [_tree addObject:fizzy forKey:@"Drinks"];
        [_tree addObject:alcohol forKey:@"Drinks"];
        [_tree addObject:juices forKey:@"Drinks"];
        [_tree addObject:milkShakes forKey:@"Drinks"];
        [_tree addObject:water forKey:@"Drinks"];
        [_tree addObject:milk forKey:@"Drinks"];
        
        
        TreeItem *orangeJuice = [[TreeItem alloc] initWithCaption:@"Orange Juice" andImage:[UIImage imageNamed:@"orange-juice.jpg"]];
        
        [_tree addObject:orangeJuice forKey:@"Juices"];
        

    }
    
    return self;
}

- (NSArray *)getItems:(id)aKey
{
    return [_tree objectsForKey:aKey];
}



@end
