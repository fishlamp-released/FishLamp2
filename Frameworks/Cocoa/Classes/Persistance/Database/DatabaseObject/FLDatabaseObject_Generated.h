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

#import "FLModelObject.h"

// --------------------------------------------------------------------
// FLDatabaseObject
// --------------------------------------------------------------------
@interface FLDatabaseObject_Generated : NSObject<NSCopying, FLModelObject>{ 
@private
    NSString* __identifier;
} 


@property (readwrite, strong) NSString* identifier;

+ (NSString*) identifierKey;

+ (id) databaseObject; 

@end

@interface FLDatabaseObject_Generated (ValueProperties) 
@end

// [/Generated]
