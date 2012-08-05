//
//	FLSoapWebServiceManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLWebServiceManager.h"

@implementation FLWebServiceManager

- (NSString*) url
{
	FLAssertFailed(@"must override this");
	return nil;
}

- (NSString*) targetNamespace
{
	FLAssertFailed(@"must override this");
	return nil;
}

@end
