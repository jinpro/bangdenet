//
//  SearchViewController.m
//  bangdenet
//
//  Created by jin on 13-3-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "SearchViewController.h"
#import "Request.h"
#import "FilePath.h"
#import "QuestionCell.h"
@interface SearchViewController ()
@property (copy,nonatomic) NSString* FlagString;
@end

@implementation SearchViewController{
    NSArray* data;
    NSString* strLocation;
    int CurrentRow;
}

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
    strLocation=nil;
    TheManager=[[CLLocationManager alloc] init];
    TheManager.delegate=self;
    TheManager.desiredAccuracy=kCLLocationAccuracyBest;
    count=0;
    NSString* flagPath=[FilePath getFlagPath];
    flagStr=[[NSString alloc] initWithContentsOfFile:flagPath encoding:NSUTF8StringEncoding error:nil];
    self.FlagString=flagStr;
    if([flagStr isEqualToString:@"fri"])
    {
            NSString* FriPath=[FilePath getFriPath];
            NSString* SelPath=[FilePath getSelPath];
            NSArray* FriList=[[NSArray alloc] initWithContentsOfFile:FriPath];
            NSString* SelStr=[[NSString alloc] initWithContentsOfFile:SelPath encoding:NSUTF8StringEncoding error:nil];
            NSDictionary* dict=[FriList objectAtIndex:[SelStr intValue]];
            Request* req=[[Request alloc] init];
            
            NSString* user=[dict objectForKey:@"u_name"];
            
       
            [req setFile:@"/task/get_my_task.php"];
            
            
            [req add:user forkey:@"user"];
            
            NSFileManager* fm=[[NSFileManager alloc] init];
            [fm removeItemAtPath:flagPath error:nil];
            
            data=[req getList];
            
            
            NSLog(@"%d\n",[data count]);
        
        
            [self.tableView reloadData];
        
    }else{
        
        [TheManager startUpdatingLocation];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [data count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    QuestionCell* cell=[[QuestionCell alloc] init];
    NSDictionary* dict=nil;
 
    dict=[data objectAtIndex:indexPath.row];
    
    if(![flagStr isEqualToString:@"fri"])
    {
        cell.PublisherName.text=[dict objectForKey:@"u_name"];
    }
    else
    {
        cell.PublisherName.text=@"";
    }
    NSString* LocationString=[dict objectForKey:@"t_location"];
    NSArray* LocationArray=[LocationString componentsSeparatedByString:@","];
    CLLocation* OthersLocation=[[CLLocation alloc] initWithLatitude:[[LocationArray objectAtIndex:1] floatValue] longitude:[[LocationArray objectAtIndex:0] floatValue]];
    
    
    NSString *DistanceString=[NSString stringWithFormat:@"距离%0.2f km",[[TheManager location] distanceFromLocation:OthersLocation]/1000];
    
    
    //[[TheManager location] distanceFromLocation:];
    cell.ContentLabel.text=[dict objectForKey:@"t_text"];
    cell.ClassLabel.text=[dict objectForKey:@"t_title"];
    cell.TimeLabel.text=[dict objectForKey:@"time"];
    cell.DistanceLabel.text=DistanceString;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    QuestionCell* Cell=(QuestionCell*)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return Cell.frame.size.height;
}
- (IBAction)SearchByLocation:(id)sender {
    
    if (strLocation==nil) {
        [TheManager startUpdatingLocation];
        NSLog(@"没有获得地理位置");
    }else{
        NSLog(@"已经获得地理位置");
        [self searchQuestions];
    }
    
    
    
}



-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    
    count++;
    if(locations.count)
    {
        location=[locations objectAtIndex:0];
        
        
        strLocation=[NSString stringWithFormat:@"%f,%f",location.coordinate.longitude,location.coordinate.latitude];
        if(count==1)
        {
            [self searchQuestions];
            
            
        }else{
            [TheManager stopUpdatingLocation];
        }
        
        
        
    }
}

-(void)searchQuestions{
    
    HUB=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUB];
    HUB.dimBackground=YES;
    
    [HUB showAnimated:YES whileExecutingBlock:^{
        Request* req=[[Request alloc] init];
        [req setFile:@"/task/get_list_by_location.php"];
        [req add:strLocation  forkey:@"location"];
        [req add:[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"] forkey:@"u_name"];
        data=[req getList];
        
        [data writeToFile:[FilePath getTaskPath]
               atomically:YES];
        
    } completionBlock:^{
        [self.tableView reloadData];
        
    }];

}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.hidesBottomBarWhenPushed=YES;
    CurrentRow=indexPath.row;
    [[NSString stringWithFormat:@"%d",indexPath.row] writeToFile:[FilePath getSelPath] atomically:YES encoding:NSUTF8StringEncoding error:nil];
    [data writeToFile:[FilePath getTaskPath] atomically:YES];
    [self performSegueWithIdentifier:@"AllRes" sender:self];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"AllRes"]) {
        [segue.destinationViewController setValue:[data objectAtIndex:CurrentRow] forKey:@"QuestionDictionary"];
    }
}


-(void)viewDidAppear:(BOOL)animated{
    if ([self.FlagString isEqualToString:@"fri"]) {
        self.tabBarController.tabBar.hidden=YES;
    }else{
        self.tabBarController.tabBar.hidden=NO;
    }
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    self.tabBarController.tabBar.hidden=YES;
}




@end
