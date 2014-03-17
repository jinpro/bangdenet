//
//  FilePath.m
//  bangdenet
//
//  Created by jin on 13-3-8.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "FilePath.h"

@implementation FilePath


+(NSString*)getTaskPath{
    NSString* tempPath=NSTemporaryDirectory();
    
    NSString* Path=[tempPath stringByAppendingString:@"task_list.txt"];
    
    return Path;
}

+(NSString*)getSelPath{
    NSString* tempPath=NSTemporaryDirectory();
    
    NSString* Path=[tempPath stringByAppendingString:@"sel.txt"];
    
    
    return Path;
    
}

+(NSString*)getMyPath{
    
    NSString* tempPath=NSTemporaryDirectory();
    
    NSString* Path=[tempPath stringByAppendingString:@"my.txt"];
    
    
    return Path;
    
    
}


+(NSString*)getFriPath{
    NSString* tempPath=NSTemporaryDirectory();
    
    NSString* Path=[tempPath stringByAppendingString:@"fri.txt"];
    
    
    return Path;
    
}
+(NSString*)getFlagPath{
    NSString* tempPath=NSTemporaryDirectory();
    
    NSString* Path=[tempPath stringByAppendingString:@"flag.txt"];
    
    
    return Path;
    
    
}

+(NSString*)getUserProfilePath{
    
    
    
    NSArray* Paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",[Paths objectAtIndex:0]);
    
    NSString* UserProfilePath=[[Paths objectAtIndex:0] stringByAppendingPathComponent:@"/user_profile.plist"];
    return UserProfilePath;
}

+(NSString*)getMessageCountPath{
    
    NSArray* Paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    NSString* MessageCountPath=[[Paths objectAtIndex:0] stringByAppendingPathComponent:@"/message_count.plist"];
    return MessageCountPath;
}

+(NSString*)getUserInfoPath{
    NSArray* Paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@",[Paths objectAtIndex:0]);
    
    NSString* UserProfilePath=[[Paths objectAtIndex:0] stringByAppendingPathComponent:@"/user_info.plist"];
    return UserProfilePath;
    
}

+(BOOL)isPathExists:(NSString *)Path{
    
    NSFileManager* FileManager=[NSFileManager defaultManager];
    return [FileManager fileExistsAtPath:Path];
}
@end
