//
//  NotificatingUserMethods.h
//  bangdenet
//
//  Created by jin on 3/11/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CWStatusBarNotification.h"
@interface NotificatingUserMethods : NSObject

+(void)showMessageInStatusBar:(NSString*)MessageText;
+(void)showMessageInAlertView:(NSString*)MessageText;
@end
