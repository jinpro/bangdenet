//
//  BasicCell.m
//  bangdenet
//
//  Created by jin on 3/13/14.
//  Copyright (c) 2014 apple. All rights reserved.
//

#import "BasicCell.h"

@implementation BasicCell

-(id)init{
    
    self=[[[NSBundle mainBundle] loadNibNamed:@"BasicCell" owner:self options:nil] lastObject];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
