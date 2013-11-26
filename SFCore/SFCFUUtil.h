//
//  SFCFUUtil.h
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFCFUUtil : NSObject

+ (NSString*)documentDir;
+ (NSString*)tempDir;
+ (NSString*)docDirForName:(NSString*)name;
+ (NSString*)tempDirForName:(NSString*)name;
+ (NSString*)dir:(NSString*)name forDir:(NSString*)dir;

+ (BOOL)fileExistsAtPath:(NSString*)path;
+ (BOOL)removeFileAtPath:(NSString*)path;

@end
