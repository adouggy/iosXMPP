//
//  SFCDBStatment.m
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import "SFCDBStatment.h"

@implementation SFCDBStatment

- (id)initWithStatment:(sqlite3_stmt*)statment
{
    self = [super init];
    if (self)
    {
        m_Statment = statment;
    }
    return self;
}

- (sqlite3_stmt*)statment
{
    return m_Statment;
}

- (BOOL)hasMoreResults
{
    if (!m_Statment)
    {
        return NO;
    }
    return (SQLITE_ROW == sqlite3_step(m_Statment));
}

- (int)columnCount
{
    if (!m_Statment)
    {
        return 0;
    }
    return sqlite3_column_count(m_Statment);
}

- (SFCDBColumnType)columnType:(int)index
{
    if (!m_Statment)
    {
        return SFCDBColumnTypeInvalid;
    }
    int type = sqlite3_column_type(m_Statment, index);
    switch (type)
    {
        case SQLITE_INTEGER:
            return SFCDBColumnTypeInt;
        case SQLITE_FLOAT:
            return SFCDBColumnTypeFloat;
        case SQLITE_TEXT:
            return SFCDBColumnTypeString;
        default:
            return SFCDBColumnTypeInvalid;
    }
    return SFCDBColumnTypeInvalid;
}

- (NSString*)columnName:(int)index
{
    if (!m_Statment)
    {
        return nil;
    }
    const char* name = sqlite3_column_name(m_Statment, index);
    return [[NSString alloc] initWithUTF8String:name];
}

- (NSString*)stringValueOfColumn:(NSInteger)column
{
    if (!m_Statment)
    {
        return nil;
    }
    
    const char* str = (const char*)sqlite3_column_text(m_Statment, column);
    if (!str)
    {
        return nil;
    }
    return [NSString stringWithCString:str encoding:NSUTF8StringEncoding];
}

- (int)intValueOfColumn:(NSInteger)column
{
    if (!m_Statment)
    {
        return 0;
    }
    
    return sqlite3_column_int(m_Statment, column);
}

- (double)doubleValueOfColumn:(NSInteger)column
{
    if (!m_Statment)
    {
        return 0;
    }
    
    return sqlite3_column_double(m_Statment, column);
}

- (BOOL)bindIntParam:(int)param index:(int)index
{
    return (SQLITE_OK == sqlite3_bind_int(m_Statment, index, param));
}

- (BOOL)bindDoubleParam:(double)param index:(int)index
{
    return (SQLITE_OK == sqlite3_bind_double(m_Statment, index, param));
}
- (BOOL)bindStringParam:(NSString*)param index:(int)index
{
    const char* cStringValue = [param UTF8String];
    return (SQLITE_OK == sqlite3_bind_text(m_Statment, index, cStringValue, strlen(cStringValue), SQLITE_STATIC));
}

- (BOOL)finialize
{
    return (SQLITE_OK == sqlite3_finalize(m_Statment));
}

@end
