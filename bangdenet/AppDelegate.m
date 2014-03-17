//
//  AppDelegate.m
//  bangdenet
//
//  Created by jin on 13-3-4.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "AppDelegate.h"
#import "Request.h"
#import "ListenToNewMessageOperation.h"
#import "FilePath.h"
@implementation AppDelegate{
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSLog(@"启动！");
    
    self.window=[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    UIStoryboard* MainStoryBoard=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    
    NSFileManager* FileManager=[NSFileManager defaultManager];
    UIViewController* StartVC=nil;
    if ([FileManager fileExistsAtPath:[FilePath getUserProfilePath]]) {
        
        NSDictionary* UserProfile=[NSDictionary dictionaryWithContentsOfFile:[FilePath getUserProfilePath]];
        [[NSUserDefaults standardUserDefaults] setValue:[UserProfile objectForKey:@"u_name"] forKey:@"u_name"];
        [[NSUserDefaults standardUserDefaults] setValue:[UserProfile objectForKey:@"u_pwd"] forKey:@"u_pwd"];
        StartVC=[MainStoryBoard instantiateViewControllerWithIdentifier:@"MainVC"];
        
    }else{
        StartVC=[MainStoryBoard instantiateInitialViewController];
    }
    
    self.window.rootViewController=StartVC;
    
    NSLog(@"启动完成");
    [self.window makeKeyAndVisible];

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
