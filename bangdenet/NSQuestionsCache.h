//
//  NSQuestionsCache.h
//  bangdenet
//
//  Created by jin on 2/21/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSQuestionsCache : NSObject


+(void)addWithid:(id)Question;
+(void)deleteAtIndex:(NSUInteger)Index;
+(NSArray*)arrayOfQuestions;
@end
