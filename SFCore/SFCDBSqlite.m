//
//  SFCDBSqlite.m
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import "SFCDBSqlite.h"
#import "SFCDef.h"
#import "SFCDBStatment.h"
#import <objc/runtime.h>
#import "SFCDBUtil.h"
#import "DDLog.h"

@implementation SFCDBSqlite

- (id)initWithPath:(NSString*)path
{
    self = [super init];
    if (self)
    {
        m_Db = NULL;
        m_Path = path;
    }
    return self;
}

- (sqlite3*)db
{
    return m_Db;
}

- (BOOL)open:(NSError**)error
{
    if (SQLITE_OK != sqlite3_open([m_Path UTF8String], &m_Db))
    {
        int errorCode = sqlite3_errcode(m_Db);
        NSString* errorMessage = [[NSString alloc]initWithFormat:@"%s",sqlite3_errmsg(m_Db)];
        if (error != nil)
        {
            *error = [NSError errorWithDomain:SFC_DB_ERROR_DOMAIN code:errorCode userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
        }
        DDLogError(@"%@(%d)",errorMessage,errorCode);
        sqlite3_close(m_Db);
        return NO;
    }
    return YES;
}

- (BOOL)close
{
    if (SQLITE_OK != sqlite3_close(m_Db))
    {
        return NO;
    }
    return YES;
}

- (BOOL)executeSqls:(NSArray*)sqls
{
    [self beginTransaction];
    for (NSString* sql in sqls)
    {
        if (![self execute:sql error:nil])
        {
            [self rollback];
            return NO;
        }
    }
    [self commit];
    return YES;
}

- (BOOL)execute:(NSString*)sql error:(NSError**)error
{
    if (!sql || !m_Db)
    {
        return NO;
    }
    
    DDLogVerbose(@"%@",sql);
    
    char* errorMsg = nil;
    BOOL ret = (SQLITE_OK == sqlite3_exec(m_Db, [sql UTF8String], nil, nil, &errorMsg));
    
    if (!ret)
    {
        int errorCode = sqlite3_errcode(m_Db);
        NSString* errorMessage = [[NSString alloc]initWithFormat:@"%s",errorMsg];
        if (error != nil)
        {
            *error = [NSError errorWithDomain:SFC_DB_ERROR_DOMAIN code:errorCode userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
        }
        DDLogError(@"%@(%d)",errorMessage,errorCode);
    }
    sqlite3_free(errorMsg);
    
    return ret;
}

- (SFCDBStatment*)prepare:(NSString*)sql error:(NSError**)error
{
    if (!sql || !m_Db)
    {
        return nil;
    }
    
    DDLogVerbose(@"%@",sql);
    
    sqlite3_stmt* statment = NULL;
    if (SQLITE_OK != sqlite3_prepare_v2(m_Db, [sql UTF8String], -1, &statment, nil))
    {
        int errorCode = sqlite3_errcode(m_Db);
        NSString* errorMessage = [[NSString alloc]initWithFormat:@"%s",sqlite3_errmsg(m_Db)];
        if (error != nil)
        {
            *error = [NSError errorWithDomain:SFC_DB_ERROR_DOMAIN code:errorCode userInfo:@{NSLocalizedDescriptionKey : errorMessage}];
        }
        DDLogError(@"%@(%d)",errorMessage,errorCode);
        return nil;
    }
    
    return [[SFCDBStatment alloc]initWithStatment:statment];
}

- (BOOL)beginTransaction
{
    return [self execute:@"begin transaction" error:nil];
}

- (BOOL)commit
{
    return [self execute:@"commit transaction" error:nil];
}

- (BOOL)rollback
{
    return [self execute:@"rollback transaction" error:nil];
}

- (NSArray*)findAll:(Class)entityClass byConditionSql:(NSString*)conditionSql
{
    if (entityClass == nil || m_Db == nil)
    {
        return nil;
    }
    
    if (conditionSql == nil)
    {
        conditionSql = @"";
    }
    
    NSString* sql = [NSString stringWithFormat:@"select * from %s %@",class_getName(entityClass),conditionSql];
    SFCDBStatment* statment = [self prepare:sql error:nil];
    
    if (!statment)
    {
        return nil;
    }
    
    int columnCount = [statment columnCount];
    NSMutableArray* columnNames = [[NSMutableArray alloc]initWithCapacity:columnCount];
    for (int i = 0;i < columnCount;i++)
    {
        columnNames[i] = [statment columnName:i];
    }
    
    NSMutableArray* result = [[NSMutableArray alloc]init];
    
    while ([statment hasMoreResults])
    {
        id obj = [[entityClass alloc] init];
        for (int i = 0;i < columnCount;i++)
        {
            id value = nil;
            switch ([statment columnType:i])
            {
                case SFCDBColumnTypeInt:
                    value = [NSNumber numberWithInt:[statment doubleValueOfColumn:i]];
                    break;
                case SFCDBColumnTypeFloat:
                    value = [NSNumber numberWithDouble:[statment doubleValueOfColumn:i]];
                    break;
                case SFCDBColumnTypeString:
                    value = [statment stringValueOfColumn:i];
                    break;
                default:
                    break;
            }
            if (value != nil)
            {
                [obj setValue:value forKey:columnNames[i]];
            }
        }
        [result addObject:obj];
    }
    [statment finialize];
    return result;
}

- (NSArray*)findAll:(Class)entityClass
{
    return [self findAll:entityClass byConditionSql:nil];
}

- (NSArray*)findAll:(Class)entityClass byDict:(NSDictionary*)condition
{
    NSMutableString* whereSql = [[NSMutableString alloc]initWithString:@""];
    if (condition != nil)
    {
        NSArray* keys = [condition allKeys];
        NSInteger keyCount = keys.count;
        for (int i = 0;i < keyCount;i++)
        {
            if (i == 0)
            {
                [whereSql appendString:@"where"];
            }
            NSString* key = keys[i];
            id value = condition[key];
            if ([value isKindOfClass:[NSString class]])
            {
                [whereSql appendFormat:@" %@=\"%@\"",key,value];
            }
            else
            {
                [whereSql appendFormat:@" %@=%@",key,value];
            }
            if (i != keyCount - 1)
            {
                [whereSql appendString:@" and"];
            }
        }
    }
    
    return [self findAll:entityClass byConditionSql:whereSql];
}

- (id)find:(Class)entityClass byConditionSql:(NSString*)conditionSql
{
    NSArray* array = [self findAll:entityClass byConditionSql:conditionSql];
    if (array.count > 0)
    {
        return array[0];
    }
    else
    {
        return nil;
    }
}
- (id)find:(Class)entityClass byDict:(NSDictionary*)condition
{
    NSArray* array = [self findAll:entityClass byDict:condition];
    if (array.count > 0)
    {
        return array[0];
    }
    else
    {
        return nil;
    }
}
- (id)find:(Class)entityClass byId:(NSString*)id
{
    NSArray* array = [self findAll:entityClass byDict:@{@"_id" : id}];
    if (array.count > 0)
    {
        return array[0];
    }
    else
    {
        return nil;
    }
}

- (BOOL)save:(id)object
{
    if (!object || !m_Db)
    {
        return NO;
    }
    
    Class entityClass = [object class];
    
    NSMutableString* sql = [[NSMutableString alloc]initWithFormat:@"insert into %s values(",class_getName(entityClass)];
    
    unsigned int propertyCount;
    objc_property_t* propertyList = class_copyPropertyList(entityClass,&propertyCount);
    BOOL isFirstProperty = YES;
    for (int i = 0;i < propertyCount;i++)
    {
        SFCDBColumnType propertyType = [SFCDBUtil getProperyType:propertyList[i]];
        if (propertyType == SFCDBColumnTypeInvalid)
        {
            continue;
        }
        if (!isFirstProperty)
        {
            [sql appendString:@","];
        }
        else
        {
            isFirstProperty = NO;
        }
        NSString* key = [NSString stringWithFormat:@"%s",property_getName(propertyList[i])];
        id value = [object valueForKey:key];
        switch (propertyType)
        {
            case SFCDBColumnTypeString:
                [sql appendFormat:@"'%@'",value];
                break;
            case SFCDBColumnTypeFloat:
            case SFCDBColumnTypeInt:
                [sql appendFormat:@"%@",value];
                break;
            default:
                break;
        }
    }
    [sql appendString:@")"];
    
    return [self execute:sql error:nil];
}
- (BOOL)update:(id)object
{
    if (!object || !m_Db)
    {
        return NO;
    }
    
    Class entityClass = [object class];
    
    NSMutableString* sql = [[NSMutableString alloc] initWithFormat:@"update %s set ",class_getName(entityClass)];

    unsigned int propertyCount;
    objc_property_t* propertyList = class_copyPropertyList(entityClass,&propertyCount);
    BOOL isFirstProperty = YES;
    for (int i = 0;i < propertyCount;i++)
    {
        SFCDBColumnType propertyType = [SFCDBUtil getProperyType:propertyList[i]];
        NSString* key = [NSString stringWithFormat:@"%s",property_getName(propertyList[i])];
        if ([key isEqualToString:@"_id"] || propertyType == SFCDBColumnTypeInvalid)
        {
            continue;
        }
        if (!isFirstProperty)
        {
            [sql appendString:@","];
        }
        else
        {
            isFirstProperty = NO;
        }
        id value = [object valueForKey:key];
        switch (propertyType)
        {
            case SFCDBColumnTypeString:
                [sql appendFormat:@"%@='%@'",key,value];
                break;
            case SFCDBColumnTypeFloat:
            case SFCDBColumnTypeInt:
                [sql appendFormat:@"%@=%@",key,value];
                break;
            default:
                break;
        }
    }
    [sql appendFormat:@" where _id='%@'",[object valueForKey:@"_id"]];
    
    return [self execute:sql error:nil];
}
- (BOOL)saveOrUpdate:(id)object
{
    if (![self save:object])
    {
        return [self update:object];
    }
    return YES;
}
- (BOOL)delete:(id)object
{
    if (!object || !m_Db)
    {
        return NO;
    }
    Class entityClass = [object class];
    
    NSString* sql = [NSString stringWithFormat:@"delete from %s where _id='%@'",class_getName(entityClass),[object valueForKey:@"_id"]];
    
    return [self execute:sql error:nil];
}

- (BOOL)delete:(Class)entityClass byId:(NSString*)id
{
    if (!id || !m_Db)
    {
        return NO;
    }
    
    NSString* sql = [NSString stringWithFormat:@"delete from %s where _id='%@'",class_getName(entityClass),id];
    
    return [self execute:sql error:nil];
}

@end
