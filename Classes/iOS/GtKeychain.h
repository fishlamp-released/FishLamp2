//
//	GtKeychain.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/18/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

extern NSString *GtKeychainErrorDomain;

enum
{
	GtKeychainErrorItemPasswordNotFound = -1999
};

@interface GtKeychain : NSObject {
 
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