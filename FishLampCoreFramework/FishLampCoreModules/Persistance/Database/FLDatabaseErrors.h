//
//  NSError+(Sqlite).h
//  FishLamp
//
//  Created by Mike Fullerton on 7/6/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

typedef enum {
	FLDatabaseErrorDatabaseAlreadyOpen = 1,
	FLDatabaseErrorDatabaseAlreadyClosed
} FLDatabaseErrorCode;

extern NSString* const FLDatabaseErrorDomain;

#define FLDatabaseErrorMessageKey @"FLDatabaseErrorMessageKey" 
#define FLDatabaseErrorFailedSqlKey @"FLDatabaseErrorFailedSqlKey" 

@interface NSError (FLDatabase)

@property (readonly, retain, nonatomic) NSString* failedSql;
@property (readonly, retain, nonatomic) NSString* sqliteErrorMessage;

@property (readonly, assign, nonatomic) BOOL isTableDoesNotExistError;

@end