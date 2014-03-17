//
//  ViewController.h
//  bangdenet
//
//  Created by jin on 13-3-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "MBProgressHUD.h"
@interface ViewController : UIViewController{
    MBProgressHUD* HUB;
    NSString* result;
}
@property (weak, nonatomic) IBOutlet UITextField *TelNumberText;
@property (weak, nonatomic) IBOutlet UITextField *PwdText;
@property (weak, nonatomic) IBOutlet UILabel *TipLabel;

@property (weak, nonatomic) IBOutlet UIButton *LoginButton;

@end
