//
//	FLKeychain.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/18/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLKeychain.h"
#import "FLCoreFoundation.h"
NSString *FLKeychainErrorDomain = @"FLKeychainErrorDomain";

// SecBase.h

OSStatus FLKeychainDeleteHttpPassword(NSString* userName, NSString* domain) {
    FLAssertStringIsNotEmpty(userName);
    FLAssertStringIsNotEmpty(domain);

    SecKeychainItemRef itemRef = nil;
	OSStatus err = FLKeychainFindHttpPassword(userName, domain, nil, &itemRef);
    if(err == errSecItemNotFound) {
        return noErr;
    }
    
    
    if ( err == 0 ) {
#if OSX
		SecKeychainItemDelete(itemRef);
#endif        
	} 
    return err;
}

OSStatus FLKeychainSetHttpPassword(     NSString* inUserName,
                                        NSString* inDomain,
                                        NSString* inPassword ) {

    FLAssertStringIsNotEmpty(inUserName);
    FLAssertStringIsNotEmpty(inDomain);

	OSStatus err = FLKeychainDeleteHttpPassword(inUserName, inDomain);
    
    if(FLStringIsEmpty(inPassword)) {
        return err;
    }
    
#if OSX
    const char* domain = [inDomain UTF8String];
    const char* username = [inUserName UTF8String];
    const char* password = [inPassword UTF8String];
    
	//  add new password to default keychain
	OSStatus status = SecKeychainAddInternetPassword (
		NULL,								//  search default keychain
		strlen(domain),
		domain,								//  domain
		0,
		NULL,								//  security domain
		strlen(username),
		username,							//  username
		strlen(""),
		"",									//  path on domain
		0,									//  port (0 == ignore)
		kSecProtocolTypeHTTP,				//  http internet protocol
		kSecAuthenticationTypeDefault,		//  default authentication type
		strlen(password),
		password,							//  password data (stores password)
		NULL								//  ref to the actual item (not needed now)
	);
#endif

    if(status != noErr) {
        FLLog(@"addInternetPassword returned %d", status);
    }

    return status;
}

OSStatus FLKeychainFindHttpPassword(    NSString* inUserName,
                                        NSString* inDomain,
                                        NSString** outPassword,
                                        SecKeychainItemRef *outItemRef) {

    FLAssertStringIsNotEmpty(inUserName);
    FLAssertStringIsNotEmpty(inDomain);

    if(outPassword) {
        *outPassword = nil;
    }

    if(outItemRef) {
        *outItemRef = nil;
    }

    if(FLStringIsEmpty(inUserName)) {
        return 0;
    }


#if OSX                                        
    const char* domain = [inDomain UTF8String];
    const char* username = [inUserName UTF8String];
    
	void* passwordBytes = nil;
	UInt32 passwordSize = 0;
    SecKeychainItemRef itemRef;

	//  search the default keychain for a password
	OSStatus err = SecKeychainFindInternetPassword (
		NULL,								//  search default keychain
		strlen(domain),
		domain,								//  domain
		0,
		NULL,								//  security domain
		strlen(username),
		username,							//  username
		strlen(""),
		"",									//  path on domain
		0,									//  port (0 == ignore)
		kSecProtocolTypeHTTP,				//  http internet protocol
		kSecAuthenticationTypeDefault,		//  default authentication type
		&passwordSize,
		&passwordBytes,                     //  password data (stores password)
		&itemRef							//  ptr to the actual item
	);

	if ( err == noErr ) {
    
        if(outPassword) {
            *outPassword = [[NSString alloc] initWithBytes:passwordBytes length:passwordSize encoding:NSUTF8StringEncoding];
        }
        if(outItemRef) {
            *outItemRef = itemRef;
        }
    } 

    if(passwordBytes) {
		SecKeychainItemFreeContent(NULL, passwordBytes); 
    }
#else 
    OSStatus err = 1;
#endif

    if(err != noErr) {
        FLLog(@"Find internet password returned: %d", err);
    }
    
    return err;
}


@implementation FLKeychain
	
+ (BOOL) getPasswordForUsername: (NSString *) username 
					   andServiceName: (NSString *) serviceName 
						  outPassword: (NSString**) outPassword
								error: (NSError **) error 
{
	FLAssertStringIsNotEmpty(username);
	FLAssertStringIsNotEmpty(serviceName);
	FLAssertIsNotNil(outPassword);
	
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

		FLReleaseWithNil(keys);
		FLReleaseWithNil(objects);

		FLAutoreleaseObject(query);

		// First do a query for attributes, in case we already have a Keychain item with no password data set.
		// One likely way such an incorrect item could have come about is due to the previous (incorrect)
		// version of this code (which set the password as a generic attribute instead of password data).

		NSMutableDictionary *attributeQuery = [query mutableCopy];

		[attributeQuery setObject: bridge_(id, kCFBooleanTrue) forKey:bridge_(id, kSecReturnAttributes)];

		CFTypeRef attributeResult = NULL;

		OSStatus status = SecItemCopyMatching(bridge_(CFDictionaryRef, attributeQuery), &attributeResult);
		// we only care about status, so delete the returned data.

		FLReleaseCRef_(attributeResult);
		FLReleaseWithNil(attributeQuery);

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

		FLReleaseWithNil(passwordQuery);

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
	FLAssertStringIsNotEmpty(username);
	FLAssertIsNotNil(password);
	FLAssertStringIsNotEmpty(serviceName);
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
				FLReleaseWithNil(err);
				return NO;
			}
			
			FLReleaseWithNil(err);
			FLReleaseWithNil(existingPassword); // just in case
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
				FLReleaseWithNil(keys);
				FLReleaseWithNil(objects);
				
                NSDictionary* update = [NSDictionary dictionaryWithObject: 
                    [password dataUsingEncoding: NSUTF8StringEncoding] forKey: bridge_(id,kSecValueData)];
				
				status = SecItemUpdate(bridge_(CFDictionaryRef,query), bridge_(CFDictionaryRef, update));

				FLReleaseWithNil(query);
			}
			
			FLReleaseWithNil(existingPassword);
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
			FLReleaseWithNil(keys);
			FLReleaseWithNil(objects);
			
			status = SecItemAdd(bridge_(CFDictionaryRef, query), NULL);
			
			FLReleaseWithNil(query);
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
		FLAssertStringIsNotEmpty(username);
		FLAssertStringIsNotEmpty(serviceName);
		
		NSArray *keys = [[NSArray alloc] initWithObjects: bridge_(id, kSecClass), kSecAttrAccount, kSecAttrService, kSecReturnAttributes, nil];
		NSArray *objects = [[NSArray alloc] initWithObjects: bridge_(id, kSecClassGenericPassword), username, serviceName, kCFBooleanTrue, nil];
		
		NSDictionary *query = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];
		FLReleaseWithNil(keys);
		FLReleaseWithNil(objects);
		
		OSStatus status = SecItemDelete(bridge_(CFDictionaryRef, query));
		
		FLReleaseWithNil(query);
		
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

+ (NSString*) httpPasswordForUserName:(NSString*) userName
                           withDomain:(NSString*) domain
{		
	NSString *password = nil;	//  return value

// handle error??
//	OSStatus err = 
    @synchronized(self) {
        FLKeychainFindHttpPassword(userName, domain, &password, nil);
    }

	return FLAutorelease(password);
}

+ (OSStatus) setHttpPassword:(NSString*) password 
         forUserName:(NSString*) userName 
          withDomain:(NSString*) domain {

    OSStatus status = 0;
	@synchronized(self) {
        status = FLKeychainSetHttpPassword(userName, domain, password);
    }
    return status;
    
}


+ (void) removeHttpPasswordForUserName:(NSString*) userName 
                            withDomain:(NSString*) domain {
	@synchronized(self) {
        FLKeychainDeleteHttpPassword(userName, domain);
    }
}


@end
