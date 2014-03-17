//
//  LeaveMessageViewController.h
//  bangdenet
//
//  Created by jin on 2/21/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaveMessageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *MessageText;

@property(copy,nonatomic) NSString* HostUserName;
@end
