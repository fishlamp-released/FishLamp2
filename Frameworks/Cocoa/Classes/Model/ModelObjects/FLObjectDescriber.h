

//
//  FLObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FishLamp.h"
#import "FLCoreTypes.h"

@class FLObjectEncoder;
@class FLObjectDescriber;
@class FLOrderedCollection;

@protocol FLDescribable <NSObject>
@optional
+ (FLObjectDescriber*) objectDescriber;
- (FLObjectDescriber*) objectDescriber;

+ (void) objectDescriberWasCreated:(FLObjectDescriber*) describer;
@end

@interface NSObject (FLObjectDescriber)
+ (void) objectDescriberWasCreated:(FLObjectDescriber*) describer;
@end

@interface FLObjectDescriber : NSObject {
@private
    NSString* _identifier;
    Class _objectClass;
    FLOrderedCollection* _subtypes;
    FLObjectEncoder* _objectEncoder;
}
@property (readonly, assign) Class objectClass;
@property (readonly, strong) NSString* identifier;
@property (readonly, strong) FLObjectEncoder* objectEncoder;
@property (readonly, assign) NSUInteger subTypeCount;

@property (readonly, copy) NSArray* subTypesCopy;

- (FLObjectDescriber*) subTypeForIdentifier:(NSString*) identifier;
- (FLObjectDescriber*) subTypeForIndex:(NSUInteger) idx;
- (NSString*) identifierForIndex:(NSUInteger) idx;

+ (id) objectDescriber:(Class) aClass;
+ (id) objectDescriber:(NSString*) identifier class:(Class) aClass;
@end
            
@interface FLObjectDescriber (FLObjectDescriberTypeDefinition)

+ (void) registerClass:(Class) aClass;
- (void) setSubtypeClass:(Class) aClass forIdentifier:(NSString*) identifier;
- (void) setSubtypeArrayTypes:(NSArray*) arrayTypes forIdentifier:(NSString*) identifier;
- (void) addSubtype:(FLObjectDescriber*) subtype;

// deprecated
- (id) initWithClass:(Class) aClass;
- (void) setChildForIdentifier:(NSString*) name withClass:(Class) objectClass;
- (void) setChildForIdentifier:(NSString*) name withArrayTypes:(NSArray*) types;
@end            