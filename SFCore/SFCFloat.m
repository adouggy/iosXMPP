//
//  SFCFloat.m
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-26.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import "SFCFloat.h"

@implementation SFCFloat

- (id)initWithDouble:(double)value
{
    self = [super init];
    if (self)
    {
        _value = value;
    }
    return self;
}
+ (SFCFloat*)floatWrapperWithDouble:(double)value
{
    return [[SFCFloat alloc]initWithDouble:value];
}

@end
