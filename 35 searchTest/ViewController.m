//
//  ViewController.m
//  35 searchTest
//
//  Created by Андрей on 4/21/15.
//  Copyright (c) 2015 Андрей. All rights reserved.
//
// this is new coment
//222222222222222222222222
//12121212121212121212121212121212211212121
//56565655656565656565656565656565656565
#import "ViewController.h"
#import "NSString+Random.h"
#import "section.h"

@interface ViewController ()

@property (strong, nonatomic) NSArray* namesArray;

@property (strong, nonatomic) NSMutableArray* sectionArray;

@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.namesArray = [NSMutableArray alloc];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSMutableArray* array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 100; i++) {
        [array addObject:[[NSString randomAlphanumericString] capitalizedString]];
    }
    
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"self" ascending:YES];
    
    [array sortUsingDescriptors:@[sortDescriptor]];
    
//    self.namesArray = [NSMutableArray alloc];
    self.namesArray = array;
    
    NSString* currentLetter = nil;
    
    for (NSString* string in self.namesArray) {
        
        NSString* firstLetter = [string substringToIndex:1];
        
        Section* section = nil;

        
        if (![currentLetter isEqual:firstLetter]) {
            
            section = [[Section alloc] init];
            section.itemsArray = [NSMutableArray array];
            section.sectionName = currentLetter;
            currentLetter = firstLetter;
            [self.sectionArray addObject:section];
        }
        else{
            section = [self.sectionArray lastObject];
        }
        [section.itemsArray addObject:string];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.sectionArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.namesArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellString = @"cell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellString];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:cellString];
    }
    
    cell.textLabel.text = self.namesArray[indexPath.row];
    
    return cell;
    
}



@end
