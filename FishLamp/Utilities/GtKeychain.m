//
//  GtKeychain.m
//  MyZen
//
//  Created by Mike Fullerton on 12/18/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtKeychain.h"
//
//  SFHFKeychainUtils.m
//
//  Created by Buzz Andersen on 10/20/08.
//  Based partly on code by Jonathan Wight, Jon Crosby, and Mike Malone.
//  Copyright 2008 Sci-Fi Hi-Fi. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#import "GtKeychain.h"
#import <Security/Security.h>

NSString *GtKeychainErrorDomain = @"GtKeychainErrorDomain";

#if __IPHONE_OS_VERSION_MIN_REQUIRED < 30000 && TARGET_IPHONE_SIMULATOR
@interface SFHFKeychainUtils (PrivateMethods)
+ (SecKeychainItemRef) getKeychainItemReferenceForUsername: (NSString *) username andServiceName: (NSString *) serviceName error: (NSError **) error;
@end
#endif

@implementation GtKeychain
	
#if __IPHONE_OS_VERSION_MIN_REQUIRED < 30000 && TARGET_IPHONE_SIMULATOR

+ (NSString *) getPasswordForUsername: (NSString *) username 
                       andServiceName: (NSString *) serviceName 
                                error: (NSError **) error 
{
	GtAssertIsValidString(userName);
    GtAssertIsValidString(serviceName);
	
	SecKeychainItemRef item = [SFHFKeychainUtils getKeychainItemReferenceForUsername: username 
                                                                      andServiceName: serviceName 
                                                                               error: error];
                                                                               
	
	if ((error && *error) || !item) 
    {
        return nil;
	}
	
	// from Advanced Mac OS X Programming, ch. 16
    UInt32 length = 0;
    char *password = nil;
    SecKeychainAttribute attributes[8];
    SecKeychainAttributeList list;
	
    attributes[0].tag = kSecAccountItemAttr;
    attributes[1].tag = kSecDescriptionItemAttr;
    attributes[2].tag = kSecLabelItemAttr;
    attributes[3].tag = kSecModDateItemAttr;
    
    list.count = 4;
    list.attr = attributes;
    
    OSStatus status = SecKeychainItemCopyContent(item, NULL, &list, &length, (void **)&password);
	
	if (status != noErr) 
    {
		if(error)
        {
            *error = [GtAlloc(NSError) initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];
        }
		return nil;
    }

	NSString *passwordString = nil;
	
	if (password != NULL) 
    {
		char passwordBuffer[1024];
		
		if (length > 1023) 
        {
			length = 1023;
		}
		strncpy(passwordBuffer, password, length);
		
		passwordBuffer[length] = '\0';
		passwordString = [NSString stringWithCString:passwordBuffer];
	}
	
	SecKeychainItemFreeContent(&list, password);
    
    CFRelease(item);
    
    return passwordString;
}

+ (BOOL) storeUsername: (NSString *) username 
           andPassword: (NSString *) password 
        forServiceName: (NSString *) serviceName 
        updateExisting: (BOOL) updateExisting 
                 error: (NSError **) error 
{	
	GtAssertIsValidString(userName);
    GtAssertIsValidString(serviceName);
    GtAssertIsValidString(password);

	SecKeychainItemRef item = [SFHFKeychainUtils getKeychainItemReferenceForUsername: username andServiceName: serviceName error: error];
	
	if ((error && *error) && [*error code] != noErr) 
    {
		return NO;
	}
	
	if(error)
    {
        GtReleaseWithNil(*error);
    }
    
	OSStatus status = noErr;
	
	if (item) 
    {
		status = SecKeychainItemModifyAttributesAndData(item,
														NULL,
														strlen([password UTF8String]),
														[password UTF8String]);
		
		CFRelease(item);
	}
	else 
    {
		status = SecKeychainAddGenericPassword(NULL,                                     
											   strlen([serviceName UTF8String]), 
											   [serviceName UTF8String],
											   strlen([username UTF8String]),                        
											   [username UTF8String],
											   strlen([password UTF8String]),
											   [password UTF8String],
											   NULL);
	}
	
	if (status != noErr) 
    {
		if(error)
        {
            *error = [GtAlloc(NSError) initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];
        }
    
        return NO;
    }
    
    return YES;
}

+ (BOOL) deleteItemForUsername: (NSString *) username 
                andServiceName: (NSString *) serviceName 
                         error: (NSError **) error 
{
	GtAssertIsValidString(userName);
    GtAssertIsValidString(serviceName);
	
	SecKeychainItemRef item = [SFHFKeychainUtils getKeychainItemReferenceForUsername: username andServiceName: serviceName error: error];
	
	if ((error && *error) && [*error code] != noErr) 
    {
		return NO;
	}
	
	OSStatus status = 0;
	
	if (item) 
    {
		status = SecKeychainItemDelete(item);
		CFRelease(item);
	}
	
	if (status != noErr) 
    {
		if(error)
        {
            *error = [GtAlloc(NSError) initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];
        }
        
        return NO;
	}
    
    return YES;
}

+ (SecKeychainItemRef) getKeychainItemReferenceForUsername: (NSString *) username 
                                            andServiceName: (NSString *) serviceName 
                                                     error: (NSError **) error 
{
	GtAssertIsValidString(userName);
    GtAssertIsValidString(serviceName);
		
	SecKeychainItemRef item;
	
	OSStatus status = SecKeychainFindGenericPassword(NULL,
													 strlen([serviceName UTF8String]),
													 [serviceName UTF8String],
													 strlen([username UTF8String]),
													 [username UTF8String],
													 NULL,
													 NULL,
													 &item);
	
	if (status != noErr) 
    {
		if (status != errSecItemNotFound) 
        {
			if(error)
            {
                *error = [GtAlloc(NSError) initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];
            }
		}
		
		return nil;		
	}
	
	return item;
}

#else

+ (BOOL) getPasswordForUsername: (NSString *) username 
                       andServiceName: (NSString *) serviceName 
                          outPassword: (NSString**) outPassword
                                error: (NSError **) error 
{
	GtAssertIsValidString(username);
    GtAssertIsValidString(serviceName);
    GtAssertNotNil(outPassword);

	// Set up a query dictionary with the base query attributes: item type (generic), username, and service
	
	NSArray *keys = [GtAlloc(NSArray) initWithObjects: (NSString *) kSecClass, kSecAttrAccount, kSecAttrService, nil];
	NSArray *objects = [GtAlloc(NSArray) initWithObjects: (NSString *) kSecClassGenericPassword, username, serviceName, nil];

	NSMutableDictionary *query = [GtAlloc(NSMutableDictionary) initWithObjects: objects forKeys: keys];

    GtReleaseWithNil(keys);
    GtReleaseWithNil(objects);
	
    [query autorelease];
    
	// First do a query for attributes, in case we already have a Keychain item with no password data set.
	// One likely way such an incorrect item could have come about is due to the previous (incorrect)
	// version of this code (which set the password as a generic attribute instead of password data).
	
	NSMutableDictionary *attributeQuery = [query mutableCopy];
	
    [attributeQuery setObject: (id) kCFBooleanTrue forKey:(id) kSecReturnAttributes];
	
    NSDictionary *attributeResult = NULL;
	
    OSStatus status = SecItemCopyMatching((CFDictionaryRef) attributeQuery, (CFTypeRef *) &attributeResult);
	// we only care about status, so delete the returned data.
	GtRelease(attributeResult);
	GtRelease(attributeQuery);
	
	if (status != noErr) 
    {
		// No existing item found--simply return nil for the password
		if (status == errSecItemNotFound) 
        {
            status = GtKeychainErrorItemPasswordNotFound;
        }
        
        if(error)
        { 
            *error = [GtAlloc(NSError) initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];
        }
		
		return NO;
	}
	
	// We have an existing item, now query for the password data associated with it.
	
	NSData *resultData = nil;
	NSMutableDictionary *passwordQuery = [query mutableCopy];
	[passwordQuery setObject: (id) kCFBooleanTrue forKey: (id) kSecReturnData];

	status = SecItemCopyMatching((CFDictionaryRef) passwordQuery, (CFTypeRef *) &resultData);
	
	[resultData autorelease];
	GtRelease(passwordQuery);
	
	if (status != noErr) 
    {
		if (status == errSecItemNotFound) 
        {
			// We found attributes for the item previously, but no password now, so return a special error.
			// Users of this API will probably want to detect this error and prompt the user to
			// re-enter their credentials.  When you attempt to store the re-entered credentials
			// using storeUsername:andPassword:forServiceName:updateExisting:error
			// the old, incorrect entry will be deleted and a new one with a properly encrypted
			// password will be added.
			if(error)
            { 
                *error = [GtAlloc(NSError) initWithDomain: GtKeychainErrorDomain code: GtKeychainErrorItemPasswordNotFound userInfo: nil];			
            }
		}
		else 
        {
			// Something else went wrong. Simply return the normal Keychain API error code.
			if(error)
            {
                *error = [GtAlloc(NSError) initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];
            }
		}
		
		return NO;
	}
	
	if (resultData) 
    {
        if(outPassword)
        {
            *outPassword = [GtAlloc(NSString) initWithData: resultData encoding: NSUTF8StringEncoding];
        }
	}
	else 
    {
		// There is an existing item, but we weren't able to get password data for it for some reason,
		// Possibly as a result of an item being incorrectly entered by the previous code.
		// Set the GtKeychainErrorItemPasswordNotFound error so the code above us can prompt the user again.
		if(error)
        {
            *error = [GtAlloc(NSError) initWithDomain: GtKeychainErrorDomain code: GtKeychainErrorItemPasswordNotFound userInfo: nil];		
        }
        
        return NO;
	}
    
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
                *error = [err retain];
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
			//Only update if we're allowed to update existing.  If not, simply do nothing.
			
			NSArray *keys = [GtAlloc(NSArray)initWithObjects: (NSString *) kSecClass, 
							  kSecAttrService, 
							  kSecAttrLabel, 
							  kSecAttrAccount, 
							  nil];
			
			NSArray *objects = [GtAlloc(NSArray) initWithObjects: (NSString *) kSecClassGenericPassword, 
								 serviceName,
								 serviceName,
								 username,
								 nil];
			
			NSDictionary *query = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];			
			GtRelease(keys);
            GtRelease(objects);
            
            
			status = SecItemUpdate((CFDictionaryRef) query, 
                (CFDictionaryRef) [NSDictionary dictionaryWithObject: [password dataUsingEncoding: NSUTF8StringEncoding] forKey: (NSString *) kSecValueData]);

            GtRelease(query);
        }
        
        GtReleaseWithNil(existingPassword);
	}
	else 
    {
		// No existing entry (or an existing, improperly entered, and therefore now
		// deleted, entry).  Create a new entry.
		
		NSArray *keys = [GtAlloc(NSArray) initWithObjects: (NSString *) kSecClass, 
						  kSecAttrService, 
						  kSecAttrLabel, 
						  kSecAttrAccount, 
						  kSecValueData, 
						  nil];
		
		NSArray *objects = [GtAlloc(NSArray) initWithObjects: (NSString *) kSecClassGenericPassword, 
							 serviceName,
							 serviceName,
							 username,
							 [password dataUsingEncoding: NSUTF8StringEncoding],
							 nil];
		
		NSDictionary *query = [[NSDictionary alloc] initWithObjects: objects forKeys: keys];			
        GtRelease(keys);
        GtRelease(objects);
        
		status = SecItemAdd((CFDictionaryRef) query, NULL);
        
        GtRelease(query);
    }
    
	if (status != noErr) 
    {
		// Something went wrong with adding the new item. Return the Keychain error code.
		if(error)
        {
            *error = [GtAlloc(NSError) initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];
        }
        
        return NO;
	}
    
    return YES;
}

+ (BOOL) deleteItemForUsername: (NSString *) username 
                andServiceName: (NSString *) serviceName 
                         error: (NSError **) error 
{
    GtAssertIsValidString(username);
    GtAssertIsValidString(serviceName);
	
	NSArray *keys = [GtAlloc(NSArray) initWithObjects: (NSString *) kSecClass, kSecAttrAccount, kSecAttrService, kSecReturnAttributes, nil];
	NSArray *objects = [GtAlloc(NSArray) initWithObjects: (NSString *) kSecClassGenericPassword, username, serviceName, kCFBooleanTrue, nil];
	
	NSDictionary *query = [GtAlloc(NSDictionary) initWithObjects: objects forKeys: keys];
    GtRelease(keys);
    GtRelease(objects);
	
	OSStatus status = SecItemDelete((CFDictionaryRef) query);
    
    GtRelease(query);
	
	if (status != noErr) 
    {
		if(error)
        {
            *error = [GtAlloc(NSError) initWithDomain: GtKeychainErrorDomain code: status userInfo: nil];		
        }
        return NO;
	}
    
    return YES;
}

#endif

@end
