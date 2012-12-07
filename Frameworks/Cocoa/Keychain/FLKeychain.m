//
//	FLKeychain.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/18/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLKeychain.h"
#import "FLKeychain.h"
#import <Security/Security.h>

NSString *FLKeychainErrorDomain = @"FLKeychainErrorDomain";

@implementation FLKeychain
	
+ (BOOL) getPasswordForUsername: (NSString *) username 
					   andServiceName: (NSString *) serviceName 
						  outPassword: (NSString**) outPassword
								error: (NSError **) error 
{
	FLAssertStringIsNotEmpty_(username);
	FLAssertStringIsNotEmpty_(serviceName);
	FLAssertIsNotNil_(outPassword);
	
#if IOS
	@synchronized(self) {

		// Set up a query dictionary with the base query attributes: item type (generic), username, and service

		NSArray *keys = [[NSArray alloc] initWithObjects: 
                         bridge_(id, kSecClass), 
                         bridge_(id, kSecAttrAccount), 
                         bridge_(id, kSecAttrService), 
                         nil];
        
        
		NSArray *objects = [[NSArray alloc] initWithObjects: bridge_(id, kSecClassGenericPassword), username, serviceName, nil];

		NSMutableDictionary *query = [[NSMutableDictionary alloc] initWithObjects: objects forKeys: keys];

		FLReleaseWithNil_(keys);
		FLReleaseWithNil_(objects);

		FLAutoreleaseObject(query);

		// First do a query for attributes, in case we already have a Keychain item with no password data set.
		// One likely way such an incorrect item could have come about is due to the previous (incorrect)
		// version of this code (which set the password as a generic attribute instead of password data).

		NSMutableDictionary *attributeQuery = [query mutableCopy];

		[attributeQuery setObject: bridge_(id, kCFBooleanTrue) forKey:bridge_(id, kSecReturnAttributes)];

		CFTypeRef attributeResult = NULL;

		OSStatus status = SecItemCopyMatching(bridge_(CFDictionaryRef, attributeQuery), &attributeResult);
		// we only care about status, so delete the returned data.
		FLReleaseWithNil_(attributeResult);
		FLReleaseWithNil_(attributeQuery);

		if (status != noErr) 
		{
			// No existing item found--simply return nil for the password
			if (status == errSecItemNotFound) 
			{
				status = FLKeychainErrorItemPasswordNotFound;
			}
			
			if(error)
			{ 
				*error = [[NSError alloc] initWithDomain: FLKeychainErrorDomain code: status userInfo: nil];
			}
			
			return NO;
		}

		// We have an existing item, now query for the password data associated with it.

		CFTypeRef resultData = nil;
		NSMutableDictionary *passwordQuery = [query mutableCopy];
		[passwordQuery setObject: bridge_(id, kCFBooleanTrue) forKey: bridge_(id, kSecReturnData)];

		status = SecItemCopyMatching(bridge_(CFDictionaryRef, passwordQuery), &resultData);

		FLAutoreleaseObject(resultData);

		FLReleaseWithNil_(passwordQuery);

		if (status != noErr) 
		{
			if (status == errSecItemNotFound) 
			{
				// We found attributes for the item previously, but no password now, so return a special error.
				// Users of this API will probably want to detect this error and prompt the user to
				// re-enter their credentials.	When you attempt to store the re-entered credentials
				// using storeUsername:andPassword:forServiceName:updateExisting:error
				// the old, incorrect entry will be deleted and a new one with a properly encrypted
				// password will be added.
				if(error)
				{ 
					*error = [[NSError alloc] initWithDomain: FLKeychainErrorDomain code: FLKeychainErrorItemPasswordNotFound userInfo: nil];			
				}
			}
			else 
			{
				// Something else went wrong. Simply return the normal Keychain API error code.
				if(error)
				{
					*error = [[NSError alloc] initWithDomain: FLKeychainErrorDomain code: status userInfo: nil];
				}
			}
			
			return NO;
		}

		if (resultData)  {
			if(outPassword) {
				*outPassword = [[NSString alloc] initWithData: bridge_(NSData*, resultData) encoding: NSUTF8StringEncoding];
			}
		}
		else 
		{
			// There is an existing item, but we weren't able to get password data for it for some reason,
			// Possibly as a result of an item being incorrectly entered by the previous code.
			// Set the FLKeychainErrorItemPasswordNotFound error so the code above us can prompt the user again.
			if(error)
			{
				*error = [[NSError alloc] initWithDomain: FLKeychainErrorDomain code: FLKeychainErrorItemPasswordNotFound userInfo: nil];		
			}
			
			return NO;
		}
	}
#endif
	
	return YES;
}

+ (BOOL) storeUsername: (NSString *) username 
		   andPassword: (NSString *) password 
		forServiceName: (NSString *) serviceName 
		updateExisting: (BOOL) updateExisting 
				 error: (NSError **) error 
{		
	FLAssertStringIsNotEmpty_(username);
	FLAssertIsNotNil_(password);
	FLAssertStringIsNotEmpty_(serviceName);
#if IOS	
	
	@synchronized(self) {

		// See if we already have a password entered for these credentials.
		
		NSString *existingPassword = nil;
		NSError* err = nil;
		
		if(![FLKeychain getPasswordForUsername: username 
							andServiceName: serviceName 
							   outPassword:&existingPassword
									 error:&err])
		{
			if ([err code] == FLKeychainErrorItemPasswordNotFound) 
			{
				// There is an existing entry without a password properly stored (possibly as a result of the previous incorrect version of this code.
				// Delete the existing item before moving on entering a correct one.
				[self deleteItemForUsername: username andServiceName: serviceName error: error];
			}
			else if ([err code] != noErr) 
			{
				if(error)
				{
					*error = FLRetain(err);
				}
				FLReleaseWithNil_(err);
				return NO;
			}
			
			FLReleaseWithNil_(err);
			FLReleaseWithNil_(existingPassword); // just in case
		}
		
		OSStatus status = noErr;
			
		if (existingPassword) 
		{
			// We have an existing, properly entered item with a password.
			// Update the existing item.
			
			if (updateExisting && 
				(existingPassword != password) && 
				![existingPassword isEqualToString:password]) 
			{
				//Only update if we're allowed to update existing.	If not, simply do nothing.
				
				NSArray *keys = [[NSArray alloc]initWithObjects: bridge_(id, kSecClass),
								  kSecAttrService, 
								  kSecAttrLabel, 
								  kSecAttrAccount, 
								  nil];
				
				NSArray *objects = [[NSArray alloc] initWithObjects: bridge_(id, kSecClassGenericPassword), 
									 serviceName,
									 serviceName,
									 username,
									 nil];
				
				NSDictionary *query = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];			
				FLReleaseWithNil_(keys);
				FLReleaseWithNil_(objects);
				
                NSDictionary* update = [NSDictionary dictionaryWithObject: 
                    [password dataUsingEncoding: NSUTF8StringEncoding] forKey: bridge_(id,kSecValueData)];
				
				status = SecItemUpdate(bridge_(CFDictionaryRef,query), bridge_(CFDictionaryRef, update));

				FLReleaseWithNil_(query);
			}
			
			FLReleaseWithNil_(existingPassword);
		}
		else 
		{
			// No existing entry (or an existing, improperly entered, and therefore now
			// deleted, entry).	 Create a new entry.
			
			NSArray *keys = [[NSArray alloc] initWithObjects: bridge_(id, kSecClass), 
							  kSecAttrService, 
							  kSecAttrLabel, 
							  kSecAttrAccount, 
							  kSecValueData, 
							  nil];
			
			NSArray *objects = [[NSArray alloc] initWithObjects: bridge_(id, kSecClassGenericPassword), 
								 serviceName,
								 serviceName,
								 username,
								 [password dataUsingEncoding: NSUTF8StringEncoding],
								 nil];
			
			NSDictionary *query = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];			
			FLReleaseWithNil_(keys);
			FLReleaseWithNil_(objects);
			
			status = SecItemAdd(bridge_(CFDictionaryRef, query), NULL);
			
			FLReleaseWithNil_(query);
		}
		
		if (status != noErr) 
		{
			// Something went wrong with adding the new item. Return the Keychain error code.
			if(error)
			{
				*error = [[NSError alloc] initWithDomain: FLKeychainErrorDomain code: status userInfo: nil];
			}
			
			return NO;
		}
	
	}
#endif
	
	return YES;
}

+ (BOOL) deleteItemForUsername: (NSString *) username 
				andServiceName: (NSString *) serviceName 
						 error: (NSError **) error 
{
#if IOS
	
	@synchronized(self) {
		FLAssertStringIsNotEmpty_(username);
		FLAssertStringIsNotEmpty_(serviceName);
		
		NSArray *keys = [[NSArray alloc] initWithObjects: bridge_(id, kSecClass), kSecAttrAccount, kSecAttrService, kSecReturnAttributes, nil];
		NSArray *objects = [[NSArray alloc] initWithObjects: bridge_(id, kSecClassGenericPassword), username, serviceName, kCFBooleanTrue, nil];
		
		NSDictionary *query = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];
		FLReleaseWithNil_(keys);
		FLReleaseWithNil_(objects);
		
		OSStatus status = SecItemDelete(bridge_(CFDictionaryRef, query));
		
		FLReleaseWithNil_(query);
		
		if (status != noErr) 
		{
			if(error)
			{
				*error = [[NSError alloc] initWithDomain: FLKeychainErrorDomain code: status userInfo: nil];		
			}
			return NO;
		}
	}
#endif
	
	return YES;
}

@end
