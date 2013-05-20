//
//  GtSqlite.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSqlite.h"


NSString* GtSqliteTypeToString(GtSqliteType type)
{
	switch(type)
	{
		case GtSqliteTypeInteger:
			return @"INTEGER";

		case GtSqliteTypeFloat:
			return @"REAL";
		break;

		case GtSqliteTypeObject:
		case GtSqliteTypeBlob:
			return @"BLOB";
		
        case GtSqliteTypeNull:
		case GtSqliteTypeText:
			return @"TEXT";

		case GtSqliteTypeDate:
			return @"INTEGER";
			
		case GtSqliteTypeNone:
			return nil;
            
            
	}

	return nil;
}



