//
//  FLSqlite.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLSqlite.h"


NSString* FLSqliteTypeToString(FLSqliteType type)
{
	switch(type)
	{
		case FLSqliteTypeInteger:
			return @"INTEGER";

		case FLSqliteTypeFloat:
			return @"REAL";
		break;

		case FLSqliteTypeObject:
		case FLSqliteTypeBlob:
			return @"BLOB";
		
        case FLSqliteTypeNull:
		case FLSqliteTypeText:
			return @"TEXT";

		case FLSqliteTypeDate:
			return @"INTEGER";
			
		case FLSqliteTypeNone:
			return nil;
            
            
	}

	return nil;
}



