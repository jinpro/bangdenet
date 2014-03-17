//
//  MyUserInfo.m
//  bangdenet
//
//  Created by jin on 3/13/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "MyUserInfo.h"
#import "FilePath.h"
#import "Request.h"
#import "MBProgressHUD.h"
#import "NotificatingUserMethods.h"
static MyUserInfo* MUIF=nil;
@implementation MyUserInfo
-(id)init{
    return [super init];
}
+(id)defaultMyUserInfo{
    
    MUIF=[[MyUserInfo alloc]init];
    
    return MUIF;
}
-(BOOL)updateToService{
    
    Request* req=[[Request alloc] init];
    [req setFile:@"/user/update_userinfo.php"];
    [req setArguments:self.ProfileDictionary];
    NSString* result=[req submit];
    NSLog(@"服务器返回结果：%@\n",result);
    if ([result isEqualToString:@"yes"]) {
        return YES;
    }else{
        return NO;
    }
    
}
-(void)TransfromPropertysToDictionary{
    NSMutableDictionary* dict=[[NSMutableDictionary alloc] init];
    [dict setValue:self.u_name forKey:@"u_name"];
    [dict setValue:self.u_tel forKey:@"u_tel"];
    [dict setValue:self.gender forKey:@"gender"];
    [dict setValue:self.preference forKey:@"preference"];
    [dict setValue:self.motto forKey:@"motto"];
    [dict setValue:self.qq_number forKey:@"qq_number"];
    [dict setValue:self.company forKey:@"company"];
    [dict setValue:self.job_status forKey:@"job_status"];
    self.ProfileDictionary=dict;
    
    
}

-(BOOL)backupToNative{
    
    return [self.ProfileDictionary writeToFile:[FilePath getUserInfoPath] atomically:YES];

}

-(void)saveInBackground{
   
    dispatch_async(dispatch_queue_create("save_user_profile_t", NULL), ^{
       
        BOOL BackupResult=[self backupToNative];
        BOOL UpdateResult=[self updateToService];
        dispatch_async(dispatch_get_main_queue(), ^{
           
            if (BackupResult) {
                [NotificatingUserMethods showMessageInStatusBar:@"信息已保存"];
            }
        });
    });
    
}

-(void)downLoadFromService{
    
}

-(void)loadFromNative{
    NSFileManager* FileManager=[NSFileManager defaultManager];
    if ([FileManager fileExistsAtPath:[FilePath getUserInfoPath]]) {
        self.ProfileDictionary=[NSDictionary dictionaryWithContentsOfFile:[FilePath getUserInfoPath]];
    }else{
        self.ProfileDictionary=[[NSDictionary alloc]init];
    }
    
}

-(NSDictionary*)requestDataWithBlocking{
    
    [self loadFromNative];
    
    return self.ProfileDictionary;
}
@end
