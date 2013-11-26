//
//  SFCFUUtil.m
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import "SFCFUUtil.h"
#import "DDLog.h"

@implementation SFCFUUtil

+ (NSString*)documentDir
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSString*)tempDir
{
    return NSTemporaryDirectory();
}

+ (NSString*)createDir:(NSString*)dir
{
    if (![[NSFileManager defaultManager] fileExistsAtPath:dir])
    {
        NSError* error = nil;
        if (![[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error])
        {
            DDLogError(@"Create Directory Error:%@",[error localizedDescription]);
            return nil;
        }
    }
    return dir;
}

+ (NSString*)dir:(NSString*)name forDir:(NSString*)dir
{
    if (dir && name)
    {
        return [self createDir:[dir stringByAppendingPathComponent:name]];
    }
    else
    {
        return dir;
    }
}

+ (NSString*)docDirForName:(NSString*)name
{
    if (!name)
    {
        return [self documentDir];
    }
    return [self createDir:[[SFCFUUtil documentDir] stringByAppendingPathComponent:name]];
}

+ (NSString*)tempDirForName:(NSString*)name
{
    if (!name)
    {
        return [self tempDir];
    }
    return [self createDir:[NSTemporaryDirectory() stringByAppendingPathComponent:name]];
}

+ (BOOL)fileExistsAtPath:(NSString*)path
{
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)removeFileAtPath:(NSString*)path
{
    NSError* error = nil;
    BOOL ret = [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
    if (!ret || error)
    {
        DDLogError(@"Remove File Error:%@",[error localizedDescription]);
    }
    return ret;
}

@end
