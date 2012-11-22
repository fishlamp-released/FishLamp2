//
//  FLDatabase.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/25/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLDatabase_Internal.h"


NSString* FLDatabaseTypeToString(FLDatabaseType type)
{
	switch(type)
	{
		case FLDatabaseTypeInteger:
			return @"INTEGER";

		case FLDatabaseTypeFloat:
			return @"REAL";
		break;

		case FLDatabaseTypeObject:
		case FLDatabaseTypeBlob:
			return @"BLOB";
		
        case FLDatabaseTypeNull:
		case FLDatabaseTypeText:
			return @"TEXT";

		case FLDatabaseTypeDate:
			return @"INTEGER";
			
		case FLDatabaseTypeNone:
			return nil;
            
            
	}

	return nil;
}



