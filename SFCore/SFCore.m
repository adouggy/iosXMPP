//
//  SFCCore.m
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import "SFCore.h"
#import "NSString+DDXML.h"
#import "NSMutableArray+SFCore.h"
#import "NSData+SFCore.h"
#import "NSString+SFCore.h"
#import "NSData+XMPP.h"
#import "NSNumber+XMPP.h"
#import "NSXMLElement+XMPP.h"
#import "NSDate+RFC1123.h"
#import "NSDictionary+RequestEncoding.h"
#import "NSString+MKNetworkKitAdditions.h"
#import "UIAlertView+MKNetworkKitAdditions.h"

@implementation SFCore

+ (void)initialize
{
    SFC_FIX_CATEGORY_BUG_CALL(NSString_DDXML)
    SFC_FIX_CATEGORY_BUG_CALL(NSMutableArray_SFCore)
    SFC_FIX_CATEGORY_BUG_CALL(NSData_SFCore)
    SFC_FIX_CATEGORY_BUG_CALL(NSString_SFCore)
    
    SFC_FIX_CATEGORY_BUG_CALL(NSData_XMPP)
    SFC_FIX_CATEGORY_BUG_CALL(NSNumber_XMPP)
    SFC_FIX_CATEGORY_BUG_CALL(NSXMLElement_XMPP)
    
    SFC_FIX_CATEGORY_BUG_CALL(NSDate_RFC1123)
    SFC_FIX_CATEGORY_BUG_CALL(NSDictionary_RequestEncoding)
    SFC_FIX_CATEGORY_BUG_CALL(NSString_MKNetworkKitAdditions)
    SFC_FIX_CATEGORY_BUG_CALL(UIAlertView_MKNetworkKitAdditions)
    
    SFC_FIX_CATEGORY_BUG_CALL(NSArray_CHCSVAdditions)
    SFC_FIX_CATEGORY_BUG_CALL(NSString_CHCSVAdditions)
}

@end
