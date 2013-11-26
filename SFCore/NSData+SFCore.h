//
//  NSData+SFCore.h
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFCDef.h"

SFC_FIX_CATEGORY_BUG_INTERFACE(NSData_SFCore)

@interface NSData (SFCore)

+ (NSData *)dataFromBase64String:(NSString *)aString;
- (NSString *)base64EncodedString;

+ (NSData *)dataFromBytesString:(NSString *)hexString;


- (NSData*)md5Data;
- (NSData*)sha1Data;
- (NSData*)sha256Data;
- (NSString*)md5String;
- (NSString*)sha1String;
- (NSString*)sha256String;
- (NSString*)hexString;

@end
