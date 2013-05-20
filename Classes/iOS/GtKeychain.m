//
//	GtKeychain.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/18/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtKeychain.h"
#import "GtKeychain.h"
#import <Security/Security.h>

NSString *GtKeychainErrorDomain = @"GtKeychainErrorDomain";

@implementation GtKeychain
	
+ (BOOL) getPasswordForUsername: (NSString *) username 
					   andServiceName: (NSString *) serviceName 
						  outPassword: (NSString**) outPassword
								error: (NSError **) error 
{
	GtAssertIsValidString(username);
	GtAssertIsValidString(serviceName);
	GtAssertNotNil(outPassword);
	
#if IOS
	@synchronized(self) {

		// Set up a query dictionary with the base query attributes: item type (generic), username, and service

		NSArray *keys = [[NSArray alloc] initWithObjects: (NSString *) kSecClass, kSecAttrAccount, kSecAttrService, nil];
		NSArray *objects = [[NSArray alloc] initWithObjects: (NSString *) kSecClassGenericPassword, username, serviceName, nil];

		NSMutableDictionary *query = [[NSMutableDictionary alloc] initWithObjects: objects forKeys: keys];

		GtReleaseWithNil(keys);
		GtReleaseWithNil(objects);

		GtAutorelease(query);

		// First do a query for attributes, in case we already have a Keychain item with no password data set.
		// One likely way such an incorrect item could have come about is due to the previous (incorrect)
		// version of this code (which set the password as a generic attribute instead of password data).

		NSMutableDictionary *attributeQuery = [query mutableCopy];

		[attributeQuery setObject: (id) kCFBooleanTrue forKey:(id) kSecReturnAttributes];

		NSDictionary *attributeResult = NULL;

		OSStatus status = SecItemCopyMatching((CFDictionaryRef) attributeQuery, (CFTypeRef *) &attributeResult);
		// we only care about status, so delete the returned data.
		GtReleaseWithNil(attributeResult);
		GtReleaseWithNil(attributeQuery);

		if (status != noErr) 
		{
			// No existing item found--simply return nil for the password
			if (status == errSecItemNotFound) 
			{
				status = GtKeychainErrorItemPasswordNotFound;
			}
			
			if(error)
			{ 
				*error = [[NSError alloc] initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];
			}
			
			return NO;
		}

		// We have an existing item, now query for the password data associated with it.

		NSData *resultData = nil;
		NSMutableDictionary *passwordQuery = [query mutableCopy];
		[passwordQuery setObject: (id) kCFBooleanTrue forKey: (id) kSecReturnData];

		status = SecItemCopyMatching((CFDictionaryRef) passwordQuery, (CFTypeRef *) &resultData);

		GtAutorelease(resultData);
		GtReleaseWithNil(passwordQuery);

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
					*error = [[NSError alloc] initWithDomain: GtKeychainErrorDomain code: GtKeychainErrorItemPasswordNotFound userInfo: nil];			
				}
			}
			else 
			{
				// Something else went wrong. Simply return the normal Keychain API error code.
				if(error)
				{
					*error = [[NSError alloc] initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];
				}
			}
			
			return NO;
		}

		if (resultData) 
		{
			if(outPassword)
			{
				*outPassword = [[NSString alloc] initWithData: resultData encoding: NSUTF8StringEncoding];
			}
		}
		else 
		{
			// There is an existing item, but we weren't able to get password data for it for some reason,
			// Possibly as a result of an item being incorrectly entered by the previous code.
			// Set the GtKeychainErrorItemPasswordNotFound error so the code above us can prompt the user again.
			if(error)
			{
				*error = [[NSError alloc] initWithDomain: GtKeychainErrorDomain code: GtKeychainErrorItemPasswordNotFound userInfo: nil];		
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
	GtAssertIsValidString(username);
	GtAssertNotNil(password);
	GtAssertIsValidString(serviceName);
#if IOS	
	
	@synchronized(self) {

		// See if we already have a password entered for these credentials.
		
		NSString *existingPassword = nil;
		NSError* err = nil;
		
		if(![GtKeychain getPasswordForUsername: username 
							andServiceName: serviceName 
							   outPassword:&existingPassword
									 error:&err])
		{
			if ([err code] == GtKeychainErrorItemPasswordNotFound) 
			{
				// There is an existing entry without a password properly stored (possibly as a result of the previous incorrect version of this code.
				// Delete the existing item before moving on entering a correct one.
				[self deleteItemForUsername: username andServiceName: serviceName error: error];
			}
			else if ([err code] != noErr) 
			{
				if(error)
				{
					*error = GtRetain(err);
				}
				GtReleaseWithNil(err);
				return NO;
			}
			
			GtReleaseWithNil(err);
			GtReleaseWithNil(existingPassword); // just in case
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
				
				NSArray *keys = [[NSArray alloc]initWithObjects: (NSString *) kSecClass, 
								  kSecAttrService, 
								  kSecAttrLabel, 
								  kSecAttrAccount, 
								  nil];
				
				NSArray *objects = [[NSArray alloc] initWithObjects: (NSString *) kSecClassGenericPassword, 
									 serviceName,
									 serviceName,
									 username,
									 nil];
				
				NSDictionary *query = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];			
				GtReleaseWithNil(keys);
				GtReleaseWithNil(objects);
				
				
				status = SecItemUpdate((CFDictionaryRef) query, 
					(CFDictionaryRef) [NSDictionary dictionaryWithObject: [password dataUsingEncoding: NSUTF8StringEncoding] forKey: (NSString *) kSecValueData]);

				GtReleaseWithNil(query);
			}
			
			GtReleaseWithNil(existingPassword);
		}
		else 
		{
			// No existing entry (or an existing, improperly entered, and therefore now
			// deleted, entry).	 Create a new entry.
			
			NSArray *keys = [[NSArray alloc] initWithObjects: (NSString *) kSecClass, 
							  kSecAttrService, 
							  kSecAttrLabel, 
							  kSecAttrAccount, 
							  kSecValueData, 
							  nil];
			
			NSArray *objects = [[NSArray alloc] initWithObjects: (NSString *) kSecClassGenericPassword, 
								 serviceName,
								 serviceName,
								 username,
								 [password dataUsingEncoding: NSUTF8StringEncoding],
								 nil];
			
			NSDictionary *query = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];			
			GtReleaseWithNil(keys);
			GtReleaseWithNil(objects);
			
			status = SecItemAdd((CFDictionaryRef) query, NULL);
			
			GtReleaseWithNil(query);
		}
		
		if (status != noErr) 
		{
			// Something went wrong with adding the new item. Return the Keychain error code.
			if(error)
			{
				*error = [[NSError alloc] initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];
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
		GtAssertIsValidString(username);
		GtAssertIsValidString(serviceName);
		
		NSArray *keys = [[NSArray alloc] initWithObjects: (NSString *) kSecClass, kSecAttrAccount, kSecAttrService, kSecReturnAttributes, nil];
		NSArray *objects = [[NSArray alloc] initWithObjects: (NSString *) kSecClassGenericPassword, username, serviceName, kCFBooleanTrue, nil];
		
		NSDictionary *query = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];
		GtReleaseWithNil(keys);
		GtReleaseWithNil(objects);
		
		OSStatus status = SecItemDelete((CFDictionaryRef) query);
		
		GtReleaseWithNil(query);
		
		if (status != noErr) 
		{
			if(error)
			{
				*error = [[NSError alloc] initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];		
			}
			return NO;
		}
	}
#endif
	
	return YES;
}

@end
