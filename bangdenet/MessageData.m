//
//  MessageData.m
//  bangdenet
//
//  Created by jin on 3/19/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "MessageData.h"
#import "Request.h"
@interface MessageData ()
@property (strong,nonatomic) NSMutableArray* ObserversArray;
@property (strong,nonatomic) id data;
@end
static MessageData* MessageDataInstance=nil;
@implementation MessageData

-(id)init{
    
    self=[super init];
    return self;
}

+(id)getInstance{
    
    MessageDataInstance=[[MessageData alloc] init];
    return MessageDataInstance;
}

-(void)run{
    dispatch_queue_t new_message_t=dispatch_queue_create("newmessage", NULL);
    dispatch_async(new_message_t, ^{
        while (1) {
            Request* req=[[Request alloc] init];
            [req setFile:@"/board/get_my_board.php"];
            [req add:[[NSUserDefaults standardUserDefaults] objectForKey:@"u_name"] forkey:@"user"];
            NSArray* NewArray=[req getList];
        }
        
    });
    
    
}


-(void)removeObserver:(id<Observer>)PresentObserver{
    [self.ObserversArray removeObject:PresentObserver];
    
}

-(void)registerObserver:(id<Observer>)NewObserver{
    
    [self.ObserversArray addObject:NewObserver];
    
}

-(void)notifyObservers{
    
    for (id<Observer> Observer in self.ObserversArray) {
        
        [Observer update:self.data];
    }
    
}
@end
