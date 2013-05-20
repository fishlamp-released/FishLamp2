//
//  GtCachedUserObject.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/22/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtCachedUserObject.h"

#import "GtSqlQuery.h"
#import "GtSqlTable.h"
#import "GtObjectDatabase.h"
#import "GtDatabaseCache.h"

@implementation GtCachedUserObject

GtSynthesizeGtObjectProperty(userName, setUserName, NSString);

- (void) onInit
{
    GtFail(@"fix this");

//	self.userName = [GtUserSession instance].userLogin.userName;
	[super onInit];
}

- (void) onAddDataDescriptors:(NSMutableDictionary*) dataDescriptors
{
	GtDataDescriptor* tempDesc = [GtAlloc(GtDataDescriptor) initWithMetaData:[GtCachedUserObject userNameKey]
		type:gtStringType];
	tempDesc.primaryKey = YES;
	tempDesc.notNull = YES;
	tempDesc.hasColumn = YES;
	[dataDescriptors setObject:tempDesc forKey:tempDesc.name]; 
	GtRelease(tempDesc); 		
			
	[super onAddDataDescriptors:dataDescriptors];
}

@end
