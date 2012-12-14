// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLDatabaseObject.h
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLDatabaseObject
// --------------------------------------------------------------------
@interface FLDatabaseObject : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __uid;
} 


@property (readwrite, strong, nonatomic) NSString* uid;

+ (NSString*) uidKey;

+ (FLDatabaseObject*) databaseObject; 

@end

@interface FLDatabaseObject (ValueProperties) 
@end

// [/Generated]
