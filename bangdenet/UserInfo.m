//
//  UserInfo.m
//  bangdenet
//
//  Created by jin on 3/13/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "UserInfo.h"
#import "Request.h"
@implementation UserInfo

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
    [dict setValue:self.birthdate forKey:@"birthdate"];
    self.ProfileDictionary=dict;
    
    
}

+(NSDictionary*)UserProfileOfUserWithNameInBlocking:(NSString *)UserName{
    
    Request* req=[[Request alloc]init];
    [req setFile:@"/user/get_userinfo.php"];
    [req add:UserName forkey:@"u_name"];
    NSDictionary* Profiles=[req dictionaryOfJSON];
    
    return Profiles;
}
@end
