//
//  QuestionCell.m
//  bangdenet
//
//  Created by jin on 1/24/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "QuestionCell.h"

@implementation QuestionCell



-(id)init{
    
    
    self=[[[NSBundle mainBundle] loadNibNamed:@"QuestionCell" owner:self options:nil] lastObject];
    
    return self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

}






@end
