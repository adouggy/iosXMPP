//
//  NSMutableArray+SFCore.h
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFCDef.h"

SFC_FIX_CATEGORY_BUG_INTERFACE(NSMutableArray_SFCore)

@interface NSMutableArray (SFCore)

- (void)push:(id)object;
- (id)pop;
- (id)top;

@end
