//
//  EditTextViewController.m
//  bangdenet
//
//  Created by jin on 3/12/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "EditTextViewController.h"
#import "UIElements.h"
#define TEXT_VIEW_TAG 300
@interface EditTextViewController ()

@end

@implementation EditTextViewController
-(id)initWithString:(NSString *)TextString{
    
    self=[super init];
    self.TextString=TextString;
    return self;
}
-(void)loadView{
    
    self.view=[[[NSBundle mainBundle] loadNibNamed:@"EditText" owner:self options:nil] lastObject];
    self.TextView=(UITextView*)[self.view viewWithTag:TEXT_VIEW_TAG];
    [[self.TextView layer] setBorderWidth:1.0f];
 
    [[self.TextView layer] setBorderColor:[UIElements TintColor]];
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(finishEdit:)];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor colorWithCGColor:[UIElements TintColor]];
    
    [self.TextView becomeFirstResponder];
    
    self.TextView.text=self.TextString;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)finishEdit:(id)sender{
    
    NSString* EditedResult=self.TextView.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateInfo" object:EditedResult];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
