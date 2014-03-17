//
//  PreferenceViewController.m
//  bangdenet
//
//  Created by jin on 3/13/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "PreferenceViewController.h"
#import "BasicCell.h"
#import "ConfigInfo.h"
@interface PreferenceViewController ()

@end

@implementation PreferenceViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.DisplayArray=[ConfigInfo arrayOfDefaultPreference];
    self.tableview.allowsMultipleSelection=YES;
}
-(NSString*)EditingResult{
    NSArray* SelectedIndexPaths=self.tableview.indexPathsForSelectedRows;
    NSMutableArray* ResultArray=[[NSMutableArray alloc] init];
    for (int i=0; i<[SelectedIndexPaths count]; i++) {
        UITableViewCell* Cell=[self tableView:self.tableview cellForRowAtIndexPath:[SelectedIndexPaths objectAtIndex:i]];
        [ResultArray addObject:Cell.textLabel.text];
    }
    return [ResultArray componentsJoinedByString:@","];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
