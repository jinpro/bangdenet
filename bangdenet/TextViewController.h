//
//  TextViewController.h
//  bangdenet
//
//  Created by jin on 13-3-5.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "MBProgressHUD.h"
@interface TextViewController : UIViewController<CLLocationManagerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextViewDelegate,UIAlertViewDelegate>{
    
    MBProgressHUD* HUB;
    NSString* result;
    NSString* msg;
    int PublishFlag;
    int DoneClickCount;
    
    
}
@property (weak, nonatomic) IBOutlet UIPickerView *ClassPicker;
@property (weak, nonatomic) IBOutlet UITextView *TextView;

@property (strong ,nonatomic) CLLocationManager* manager;
@property (strong,nonatomic) CLLocation* location;
@property (weak, nonatomic) IBOutlet UITextField *TitleText;

@property (weak, nonatomic) IBOutlet UITextView *ContentText;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *PublishButton;

@end
