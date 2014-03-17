//
//  DateEditTextViewController.m
//  bangdenet
//
//  Created by jin on 3/14/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "DateEditTextViewController.h"
#define TOOLBAR_DONE_BUTTON 501
@interface DateEditTextViewController ()
@property(strong,nonatomic) UIPickerView* PickerView;
@property(weak,nonatomic) UIToolbar* toolbar;
@property(copy,nonatomic) NSString* ResultString;
@property(copy,nonatomic) NSString* ResultYear;
@property(copy,nonatomic) NSString* ResultMonth;
@property(copy,nonatomic) NSString* ResultDay;
@end

@implementation DateEditTextViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.PickerView=[[UIPickerView alloc] init];
    self.PickerView.dataSource=self;
    self.PickerView.delegate=self;
    self.TextView.inputView=self.PickerView;
    self.toolbar=[[[NSBundle mainBundle] loadNibNamed:@"doneToolBar" owner:self options:nil] lastObject];
    self.TextView.inputAccessoryView=self.toolbar;
    UIBarButtonItem* DoneButton=[[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(finishKeyboard:)];
    [self.toolbar setItems:@[DoneButton]];
    NSDateComponents* components=[[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    self.ResultYear=[NSString stringWithFormat:@"%d年",components.year];
    self.ResultMonth=[NSString stringWithFormat:@"%d月",components.month];
    self.ResultDay=[NSString stringWithFormat:@"%d日",components.day];
    
    [self.PickerView selectRow:components.year-1-1900 inComponent:0 animated:YES];
    [self.PickerView selectRow:components.month-1 inComponent:1 animated:YES];
    [self.PickerView selectRow:components.day-1 inComponent:2 animated:YES];
    [self showString];
    
}

-(void)showString{
    self.ResultString=[NSString stringWithFormat:@"%@ %@ %@",self.ResultYear,self.ResultMonth,self.ResultDay];
    self.TextView.text=self.ResultString;
    
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

-(void)finishKeyboard:(id)sender{
    NSLog(@"完成");
    [self.TextView resignFirstResponder];
    
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0) {
        return 2050-1900+1;
    }else if (component==1){
        return 12;
    }else{
        return 31;
    }
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component==0) {
        return [NSString stringWithFormat:@"%d年",1900+row];
    }else if (component==1){
        return [NSString stringWithFormat:@"%d月",row+1];
    }else{
        return [NSString stringWithFormat:@"%d日",row+1];
    }
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==0) {
        self.ResultYear=[self pickerView:pickerView titleForRow:row forComponent:component];
    }else if(component==1){
        
        self.ResultMonth=[self pickerView:pickerView titleForRow:row forComponent:component];
    }else if (component==2){
        self.ResultDay=[self pickerView:pickerView titleForRow:row forComponent:component];
    }
    [self showString];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
