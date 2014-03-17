//
//  TextViewController.m
//  bangdenet
//
//  Created by jin on 13-3-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "TextViewController.h"
#import "Request.h"
#import "NSQuestionsCache.h"
#import "NotificatingUserMethods.h"
#import "ConfigInfo.h"
@interface TextViewController ()

@end

@implementation TextViewController{
    NSArray* Classify;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    PublishFlag=0;
    DoneClickCount=0;
    NSUserDefaults* UserDefault=[NSUserDefaults standardUserDefaults];
    if ([UserDefault objectForKey:@"EditingText"]!=nil) {
        [self.TextView setText:[UserDefault objectForKey:@"EditingText"]];
    }
    return self;
}

- (IBAction)publishTask:(id)sender {
    
    
    if(DoneClickCount==0){
    [self.ContentText resignFirstResponder];
        DoneClickCount++;
        [self.PublishButton setTitle:@"发布" ];
        return ;
    }
    
    
     Request* req=[[Request alloc] init];
    [req setFile:@"/task/task_publish.php"];
    
    HUB=[[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUB];
    HUB.dimBackground=YES;
    
    [HUB showAnimated:YES whileExecutingBlock:^{
        NSString* locationStr=[NSString stringWithFormat:@"%f,%f",self.location.coordinate.longitude,self.location.coordinate.latitude];
        
        NSLog(@"%@",locationStr);
        if(self.ContentText.text.length>0)
        {
        NSString* u_name=[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"];
        [req add:[Classify objectAtIndex:[self.ClassPicker selectedRowInComponent:0]] forkey:@"t_title"];
        [req add:self.ContentText.text forkey:@"t_text"];
        [req add:locationStr forkey:@"t_location"];
        [req add:u_name forkey:@"u_name"];
        result=[req submit];
            
            NSMutableDictionary* QuestionDictionary=[[NSMutableDictionary alloc] init];
            
            [QuestionDictionary setValue:[Classify objectAtIndex:[self.ClassPicker selectedRowInComponent:0]] forKey:@"t_title"];
            [QuestionDictionary setValue:self.ContentText.text forKey:@"t_text"];
            
            NSDateFormatter* formatter=[[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            
            [QuestionDictionary setValue:[formatter stringFromDate:[NSDate date] ] forKey:@"time"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"AddQuestion" object:QuestionDictionary];
        }
        else{
            if (self.ContentText.text.length<=0) {
                msg=@"没有发布内容！";
                
            }
            
        }
        
        
    } completionBlock:^{
        if([result isEqualToString:@"ok"])
        {
            NSLog(@"成功");
            [NotificatingUserMethods showMessageInStatusBar:@"发布成功"];
            PublishFlag=1;
            [self dismissViewControllerAnimated:YES completion:nil];
            
        }
        else{
            
            [NotificatingUserMethods showMessageInStatusBar:msg];
        }
    }];
    [self.manager stopUpdatingLocation];
}

- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.ContentText becomeFirstResponder];
    Classify=[ConfigInfo arrayOfDefaultPreference];
    self.manager=[[CLLocationManager alloc] init];
    self.manager.delegate=self;
    self.manager.desiredAccuracy=kCLLocationAccuracyBest;
    
    [self.manager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    NSLog(@"调用失败！");
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    NSLog(@"开始定位！");
    if(locations.count)
    {
        self.location=[locations objectAtIndex:0];
        [self.manager stopUpdatingLocation];
    }
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [Classify count];
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [Classify objectAtIndex:row];
}





-(void)viewWillDisappear:(BOOL)animated{
    if(self.ContentText.text.length>0&&PublishFlag==0){
        
        UIAlertView* AlertView=[[UIAlertView alloc] initWithTitle:@"提示" message:@"您还有内容未发布！" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
        [AlertView show];
    }
}


-(void)textViewDidChange:(UITextView *)textView{
    NSUserDefaults* UserDefault=[NSUserDefaults standardUserDefaults];
    [UserDefault setObject:self.TextView.text forKey:@"EditingText"];
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    [self.PublishButton setTitle:@"完成"];
    DoneClickCount=0;
}

-(void)textViewDidEndEditing:(UITextView *)textView{
    [self.ContentText resignFirstResponder];
    [self.PublishButton setTitle:@"发布"];
    DoneClickCount=1;
}

@end
