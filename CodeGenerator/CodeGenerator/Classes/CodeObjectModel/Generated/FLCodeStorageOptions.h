// [Generated]
//
// This file was generated at 7/10/12 5:03 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCodeStorageOptions.h
// Project: FishLamp Code Generator
// Schema: FLCodeCodeGenerator
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLModelObject.h"


// FLCodeStorageOptions
@interface FLCodeStorageOptions : FLModelObject { 
@private
    BOOL __isStorable;
    BOOL __isPrimaryKey;
    BOOL __isIndexed;
    BOOL __isUnique;
    BOOL __isRequired;
}


/// @brief: this defaults to NO. Note that storage options are ignored if the superclass object is not storable.
@property (readwrite, assign, nonatomic) BOOL isStorable;

/// @brief: set this property to be a primary key in the data store
@property (readwrite, assign, nonatomic) BOOL isPrimaryKey;

/// @brief: set this property to be indexed for fast searches on it
@property (readwrite, assign, nonatomic) BOOL isIndexed;

/// @brief: make sure this value is unique is the data store for this type
@property (readwrite, assign, nonatomic) BOOL isUnique;

/// @brief: make sure this value isn't empty in the data store
@property (readwrite, assign, nonatomic) BOOL isRequired;

+ (FLCodeStorageOptions*) storageOptions; 

@end


// [/Generated]
