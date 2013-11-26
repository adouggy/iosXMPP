//
//  NSMutableArray+SFCore.m
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import "NSMutableArray+SFCore.h"

SFC_FIX_CATEGORY_BUG_IMPLEMENTATION(NSMutableArray_SFCore)

@implementation NSMutableArray (SFCore)

- (void)push:(id)object
{
    [self addObject:object];
}
- (id)pop
{
    id object = [self lastObject];
    [self removeLastObject];
    return object;
}
- (id)top
{
    return [self lastObject];
}

@end
