//
//  SFCInteger.m
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-26.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import "SFCInteger.h"

@implementation SFCInteger

- (id)initWithInt:(int)value
{
    self = [super init];
    if (self)
    {
        _value = value;
    }
    return self;
}
+ (SFCInteger*)integerWrapperWithInt:(int)value
{
    return [[SFCInteger alloc]initWithInt:value];
}

@end
