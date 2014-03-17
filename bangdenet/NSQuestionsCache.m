//
//  NSQuestionsCache.m
//  bangdenet
//
//  Created by jin on 2/21/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "NSQuestionsCache.h"
static NSMutableArray* QuestionsArray=nil;
static NSString* FilePath=nil;
@implementation NSQuestionsCache


+(void)initQuestions{
    NSArray* array=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* QuestionsFilePath=[[array objectAtIndex:0] stringByAppendingPathComponent:@"/questions.plist"];
    FilePath=QuestionsFilePath;
    NSFileManager* FileManager=[NSFileManager defaultManager];
    
    if ([FileManager fileExistsAtPath:QuestionsFilePath]) {
        
        QuestionsArray=[[NSMutableArray alloc] initWithContentsOfFile:QuestionsFilePath];
    }else{
        
        QuestionsArray=[[NSMutableArray alloc] init];
    }
    
}

+(void)addWithid:(id)Question{
    
    [NSQuestionsCache initQuestions];
    
    [QuestionsArray addObject:Question];
    [NSQuestionsCache save];
}

+(void)deleteAtIndex:(NSUInteger)Index{
    [NSQuestionsCache initQuestions];
    [QuestionsArray removeObjectAtIndex:Index];
    [NSQuestionsCache save];
}

+(NSArray*)arrayOfQuestions{
    
    return QuestionsArray;
}
+(void)save{
    [NSQuestionsCache initQuestions];
    [QuestionsArray writeToFile:FilePath atomically:YES];
}
@end
