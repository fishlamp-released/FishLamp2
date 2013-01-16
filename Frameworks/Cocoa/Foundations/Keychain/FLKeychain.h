//
//	FLKeychain.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/18/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"

extern NSString *FLKeychainErrorDomain;

enum
{
	FLKeychainErrorItemPasswordNotFound = -1999
};

@interface FLKeychain : NSObject {
 
}
 
//+ (BOOL) getPasswordForUsername: (NSString *) username 
//					   andServiceName: (NSString *) serviceName 
//					   outPassword:(NSString**) outPassword
//								error: (NSError **) error;
//								
//+ (BOOL) storeUsername: (NSString *) username 
//		   andPassword: (NSString *) password 
//		forServiceName: (NSString *) serviceName 
//		updateExisting: (BOOL) updateExisting 
//				 error: (NSError **) error;
//				 
//+ (BOOL) deleteItemForUsername: (NSString *) username 
//				andServiceName: (NSString *) serviceName 
//						 error: (NSError **) error;


// these are thread safe.

+ (NSString*) httpPasswordForUserName:(NSString*) userName
                           withDomain:(NSString*) domain;

+ (BOOL) setHttpPassword:(NSString*) password 
             forUserName:(NSString*) userName 
              withDomain:(NSString*) domain;

+ (void) removeHttpPasswordForUserName:(NSString*) userName 
                            withDomain:(NSString*) domain;
@end


// non atomic wrappers around sec api

extern OSStatus FLKeychainSetHttpPassword(     NSString* inUsername,
                                        NSString* inDomain,
                                        NSString* inPassword );
                                        
extern OSStatus FLKeychainFindHttpPassword(    NSString* inUserName,
                                        NSString* inDomain,
                                        NSString** outPassword,
                                        SecKeychainItemRef *outItemRef);

extern OSStatus FLKeychainDeleteHttpPassword(NSString* userName, NSString* domain);                                                                                
