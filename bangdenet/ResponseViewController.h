//
//  ResponseViewController.h
//  bangdenet
//
//  Created by jin on 13-3-7.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface ResponseViewController : UIViewController{
    MBProgressHUD* HUB;
    NSString* result;
    NSString* msg;
    NSString* t_number;
    NSString* u_name;
}
@property (weak, nonatomic) IBOutlet UITextView *ResponseText;

@end
