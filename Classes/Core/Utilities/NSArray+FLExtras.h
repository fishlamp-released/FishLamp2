//
//	FLMutableArray.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/27/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

/// @category NSArray(FLExtras)
/// @brief A Category for adding a couple of obvious methods to NSArray.

#import "FLRequired.h"

@interface NSArray (FLExtras)

/// Returns index of last object

/// @returns Index of object or NSNotFound
- (NSUInteger) indexOfLastObject; 

/// Get the first object in the array.

/// Same a [array objectAtIndex:0]
/// @returns Object or nil.
- (id) firstObject;

+ (NSArray*) arrayOfLinesFromFile:(NSString*) path encoding:(NSStringEncoding)encoding error:(NSError **)error;

+ (NSArray*) arrayOfColumnArraysFromCSVFile:(NSString*) path encoding:(NSStringEncoding)encoding error:(NSError **)error;

@end

/// @category NSMutableArray(FLExtras)
/// A Category for adding a couple of obvious methods to NSMutableArray.

@interface NSMutableArray (FLExtras)

/// Move an object from one index to another index.

- (void) moveObjectToNewIndex:(NSUInteger) fromIndex toIndex:(NSUInteger) toIndex;

/// Remove and return last object in list.

- (id) removeLastObject;

/// Push object on front of the list. 

/// Same as [list insertObject:obj atIndex:0]
- (void) pushObject:(id) object;

/// Remove and returns the first object in the list.

- (id) removeFirstObject;

/// Adds an object as normal, but then calls the configureObject block.

/// The configureBlock block takes an id as an object. 
/// For example: 
/// `[myMutableArray addObject:[NSMutableString string] configureObject:^(id theString) { 
///     [theString appendString:@"I've been configured!!"]; 
/// }];`
/// @param object The object to add.
/// @param configureObject The block to run just after adding the object to the list.
- (void) addObject:(id) object configureObject:(void (^)(id object)) configureObject;


@end

// for c style arrays
// int myArray[] = { 1, 2, 3, 4 };
// int size = FLArraySize(myArray, int);

#define FLArrayLength(__ARRAY__, __TYPE__) ((__ARRAY__) == nil ? 0 : (sizeof(__ARRAY__) / sizeof(__TYPE__)))
#define FLArrayCount FLArrayLength


@interface NSArray (FLThreadAndMutationSafe)
- (void) forwardObjectVisitor:(void (^)(id operation, BOOL* stop)) visitor;
- (BOOL) reverseObjectVisitor:(void (^)(id object, BOOL* stop)) visitor;


@end

@interface NSObject (FLLameWorkaroundForArrayRTTI)
// there are issues with isKindOfClass:[NSArray class] 
// this works around this.
- (BOOL) isArray;
@end

