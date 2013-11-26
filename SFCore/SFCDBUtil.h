//
//  SFCDBUtil.h
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "SFCDBDef.h"
#import <objc/runtime.h>

@interface SFCDBUtil : NSObject

+ (NSArray*)createTableSqls:(NSArray*)entities;

+ (SFCDBColumnType)getProperyType:(objc_property_t)propery;

@end
