//
//	FLKeychain.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/18/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FLCore.h"

extern NSString *FLKeychainErrorDomain;

enum
{
	FLKeychainErrorItemPasswordNotFound = -1999
};

@interface FLKeychain : NSObject {
 
}
 
+ (BOOL) getPasswordForUsername: (NSString *) username 
					   andServiceName: (NSString *) serviceName 
					   outPassword:(NSString**) outPassword
								error: (NSError **) error;
								
+ (BOOL) storeUsername: (NSString *) username 
		   andPassword: (NSString *) password 
		forServiceName: (NSString *) serviceName 
		updateExisting: (BOOL) updateExisting 
				 error: (NSError **) error;
				 
+ (BOOL) deleteItemForUsername: (NSString *) username 
				andServiceName: (NSString *) serviceName 
						 error: (NSError **) error;
 
@end