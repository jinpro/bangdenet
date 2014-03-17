//
//  SelectTableViewController.m
//  bangdenet
//
//  Created by jin on 3/13/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "SelectTableViewController.h"
#import "BasicCell.h"
#define TABLE_VIEW_TAG 200
@interface SelectTableViewController ()
@property(strong,nonatomic) NSArray* SelectedArray;

@end

@implementation SelectTableViewController
-(void)loadView{
    self.view=[[[NSBundle mainBundle] loadNibNamed:@"SelectTable" owner:self options:nil] firstObject];
    self.tableview=(UITableView*)[self.view viewWithTag:TABLE_VIEW_TAG];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleBordered target:self action:@selector(finish:)];
    self.SelectedArray=[self.TextString componentsSeparatedByString:@","];
    NSLog(@"count:%d\n",[self.SelectedArray count]);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

-(NSString*)EditingResult{
    UITableViewCell* Cell=[self tableView:self.tableview cellForRowAtIndexPath:[self.tableview indexPathForSelectedRow]];
    return Cell.textLabel.text;
}

-(void)finish:(id)sender{
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateInfo" object:[self EditingResult]];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.DisplayArray count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BasicCell* cell=[[BasicCell alloc] init];
    cell.textLabel.text=[self.DisplayArray objectAtIndex:indexPath.row];
    BOOL HasSelected=NO;
    for (NSString* SelectedItem in self.SelectedArray) {
        
        if ([SelectedItem isEqualToString:cell.textLabel.text]) {
            HasSelected=YES;
            break;
        }
    }
    if (HasSelected) {
        [self.tableview selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
    }
    
    return cell;
}




@end
