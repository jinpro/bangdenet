//
//  RegisterViewController.h
//  bangdenet
//
//  Created by jin on 13-3-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController{
    NSString* userFlag;
}
@property (weak, nonatomic) IBOutlet UITextField *TelNumberText;
@property (weak, nonatomic) IBOutlet UITextField *UserNameText;
@property (weak, nonatomic) IBOutlet UITextField *PwdText;

@property (weak, nonatomic) IBOutlet UISwitch *TelVision;

@property (weak, nonatomic) IBOutlet UITextField *RePwdText;

@end
