//
//  NSString+SFCore.h
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-13.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFCDef.h"

SFC_FIX_CATEGORY_BUG_INTERFACE(NSString_SFCore)

@interface NSString (SFCore)

- (NSData*)md5Data;
- (NSData*)sha1Data;
- (NSData*)sha256Data;
- (NSString*)md5String;
- (NSString*)sha1String;
- (NSString*)sha256String;
- (NSString*)escapeString;
+ (NSString*)uuidString;

@end
