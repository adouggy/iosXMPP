//
//  SFCDBUtil.m
//  SFCore
//
//  Created by Synergy_iMac1 on 12-12-12.
//  Copyright (c) 2012年 Synergyinfo. All rights reserved.
//

#import "SFCDBUtil.h"

#define SFCDB_UTIL_MAX_PROPERTY_TYPE_LEN 255

@implementation SFCDBUtil

+ (SFCDBColumnType)getProperyType:(objc_property_t)propery
{
    const char* propertyAttributes = property_getAttributes(propery);
    int i = 0;
    char propertyType[SFCDB_UTIL_MAX_PROPERTY_TYPE_LEN];
    while (propertyAttributes[i] != '\0' && propertyAttributes[i] != ',')
    {
        propertyType[i] = propertyAttributes[i];
        i++;
    }
    propertyType[i] = '\0';
    if (strcmp(propertyType,"T@\"NSString\"") == 0)
    {
        return SFCDBColumnTypeString;
    }
    else if (strcmp(propertyType,"Ti") == 0)
    {
        return SFCDBColumnTypeInt;
    }
    else if (strcmp(propertyType,"Td") == 0)
    {
        return SFCDBColumnTypeFloat;
    }
    else
    {
        return SFCDBColumnTypeInvalid;
    }
}

+ (NSString*)getProperyTypeString:(objc_property_t)propery
{
    switch ([self getProperyType:propery])
    {
        case SFCDBColumnTypeString:
            return @"text";
        case SFCDBColumnTypeInt:
            return @"int";
        case SFCDBColumnTypeFloat:
            return @"double";
        default:
            return nil;
    }
}

+ (NSArray*)createTableSqls:(NSArray*)entities
{
    if (entities == nil)
    {
        return nil;
    }
    
    NSMutableArray* createTableSqls = [[NSMutableArray alloc]initWithCapacity:entities.count];
    
    for (Class entityClass in entities)
    {
        unsigned int propertyCount;
        objc_property_t* propertyList = class_copyPropertyList(entityClass,&propertyCount);
        if (propertyCount > 0)
        {
            NSMutableString* createTableSql = [[NSMutableString alloc]initWithFormat:@"create table %s(",class_getName(entityClass)];
            BOOL isFirstProperty = YES;
            for (int i = 0;i < propertyCount;i++)
            {
                NSString* propertyType = [self getProperyTypeString:propertyList[i]];
                if (propertyType != nil)
                {
                    const char* propertyName = property_getName(propertyList[i]);
                    if (!isFirstProperty)
                    {
                        [createTableSql appendString:@","];
                    }
                    else
                    {
                        isFirstProperty = NO;
                    }
                    if (strcmp(propertyName,"_id") == 0)
                    {
                        [createTableSql appendFormat:@"%s %@ primary key",propertyName,propertyType];
                    }
                    else
                    {
                        [createTableSql appendFormat:@"%s %@",propertyName,propertyType];
                    }
                }
            }
            [createTableSql appendString:@")"];
            [createTableSqls addObject:createTableSql];
        }
    }
    return createTableSqls;
}

@end
