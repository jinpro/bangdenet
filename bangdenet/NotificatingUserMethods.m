//
//  NotificatingUserMethods.m
//  bangdenet
//
//  Created by jin on 3/11/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "NotificatingUserMethods.h"

@implementation NotificatingUserMethods

+(void)showMessageInStatusBar:(NSString*)MessageText{
    
    CWStatusBarNotification* notification=[[CWStatusBarNotification alloc] init];
    [notification displayNotificationWithMessage:MessageText forDuration:0.5f ];
}

+(void)showMessageInAlertView:(NSString *)MessageText{
    
    UIAlertView* View=[[UIAlertView alloc] initWithTitle:@"提示" message:MessageText delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [View show];
}
@end
