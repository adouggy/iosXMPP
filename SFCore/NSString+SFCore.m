//
//  NSString+SFCore.m
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-13.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import "NSString+SFCore.h"
#import "NSData+SFCore.h"
#import <CommonCrypto/CommonDigest.h>

SFC_FIX_CATEGORY_BUG_IMPLEMENTATION(NSString_SFCore)

@implementation NSString (SFCore)

- (NSData*)md5Data
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (unsigned int) strlen(cStr), result);
    return [NSData dataWithBytes:result length:CC_MD5_DIGEST_LENGTH];
}

- (NSData*)sha1Data
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
	CC_SHA1(cStr, (unsigned int) strlen(cStr), result);
    return [NSData dataWithBytes:result length:CC_SHA1_DIGEST_LENGTH];
}

- (NSData*)sha256Data
{
    const char *cStr = [self UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
	CC_SHA256(cStr, (unsigned int) strlen(cStr), result);
    return [NSData dataWithBytes:result length:CC_SHA256_DIGEST_LENGTH];
}

- (NSString*)md5String
{
    return [[self md5Data] hexString];
}
- (NSString*)sha1String
{
    return [[self sha1Data] hexString];
}
- (NSString*)sha256String
{
    return [[self sha1Data] hexString];
}

+ (NSString*)uuidString
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);
	NSString *uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(nil, uuidObj);
	CFRelease(uuidObj);
	return uuidString;
}

- (NSString*)escapeString
{
    NSUInteger length = self.length;
    NSMutableString* escapedString = [[NSMutableString alloc] init];
    BOOL isEscape = NO;
    for (int i = 0;i < length;i++)
    {
        unichar c = [self characterAtIndex:i];
        if (isEscape)
        {
            if (c == 'n')
            {
                [escapedString appendString:@"\n"];
            }
            else if (c == 'r')
            {
                
            }
            else if (c == 't')
            {
                [escapedString appendString:@"\t"];
            }
            else if (c == '\\')
            {
                [escapedString appendString:@"\\"];
            }
            else
            {
                [escapedString appendFormat:@"\\%C",c];
            }
            isEscape = NO;
            continue;
        }
        if (c == '\\')
        {
            isEscape = YES;
        }
        else
        {
            [escapedString appendFormat:@"%C",c];
        }
    }
    return escapedString;
}

@end
