//
//  Request.m
//  bangdenet
//
//  Created by jin on 13-3-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "Request.h"
#include <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "NotificatingUserMethods.h"
@implementation Request
-(id)init{
    
    
    strURL=[NSMutableString stringWithString:@"http://bander.sinaapp.com" ];
    body=nil;
    request=nil;
    url=nil;
    return self;
}

-(void)add:(NSString *)value forkey:(NSString *)key{
    
    if(body==nil)
    {
        body=[[NSMutableString alloc] init];
        [body appendFormat:@"%@=%@",key,value];
        
    }
    else
    {
        [body appendFormat:@"&%@=%@",key,value];
    }
    
   
 

}

-(void)setFile:(NSString*)FileName{
    [strURL appendString:FileName];

    
}

-(void)setArguments:(NSDictionary *)ArgumentsDictionary{
    
    NSArray* Keys=[ArgumentsDictionary allKeys];
    
    for (int i=0; i<[Keys count]; i++) {
        NSString* SKey=[Keys objectAtIndex:i];
        NSString* SValue=[ArgumentsDictionary objectForKey:SKey];
        [self add:SValue forkey:SKey];
    }
    
}

-(NSString*)submit{
    if (![self connectedToNetwork]) {
        
        return @"failed";
    }
    if(request==nil)
    {
        if(url==nil)
        url=[[NSURL alloc] initWithString:strURL ];
        
        request=[[NSMutableURLRequest alloc] initWithURL:url ];
    
    }

[request setHTTPMethod:@"POST"];
[request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
NSURLResponse* response;

NSData* data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    self.result=data;

NSString* str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding ];
    
    
 
    return str;
    
    
    
}
-(BOOL)connectedToNetwork{
    
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_family=AF_INET;
    zeroAddress.sin_len=sizeof(zeroAddress);
    SCNetworkReachabilityRef defaultReachablilityRef=SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr*)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags=SCNetworkReachabilityGetFlags(defaultReachablilityRef, &flags);
    CFRelease(defaultReachablilityRef);
    if (!didRetrieveFlags) {
        return NO;
    }
    BOOL isReachable=flags&kSCNetworkFlagsReachable;
    BOOL needsConnection=flags&kSCNetworkFlagsConnectionRequired;
    return (isReachable&&!needsConnection)?YES:NO;
     
    return YES;
    
}


+(NSString*)getInfo:(NSString*)property{
    
    NSHTTPCookieStorage* cookieJar=[NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray* array=[NSArray arrayWithArray:[cookieJar cookies]];
    NSString* result=nil;
    
    
    for(id val in array)
    {
        
        NSHTTPCookie* cookie=(NSHTTPCookie*)val;
        
        if([cookie.name isEqualToString:property])
        {
            result=cookie.value;
            break;
        }
        
    }
    
 
    return result;
    
}

-(NSMutableArray*)getList{
    
    if ([[self submit] isEqualToString:@"failed"]) {
        return [[NSMutableArray alloc] init];
    }
    
    NSMutableArray* array=[NSJSONSerialization JSONObjectWithData:self.result options:NSJSONReadingMutableLeaves error:nil];
    
    return array;
}

-(NSDictionary*)dictionaryOfJSON{
    
    NSString* resultStr=[self submit];
    if ([resultStr isEqualToString:@"failed"]) {
        return [[NSDictionary alloc] init];
    }
    NSDictionary* dict=[NSJSONSerialization JSONObjectWithData:self.result options:NSJSONReadingMutableLeaves error:nil];
    
    return dict;
    
}

@end
