

//
//  FLObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FishLamp.h"
#import "FLPropertyDescriber.h"
#import "FLCoreTypes.h"
#import "FLDatabase.h"

@class FLObjectEncoder;
@class FLObjectDescriber;

@interface NSObject (FLObjectDescriber)
+ (void) modelObjectWasRegistered:(FLObjectDescriber*) describer;
+ (FLObjectDescriber*) objectDescriber;
- (FLObjectDescriber*) objectDescriber;
@end

@interface FLObjectDescriber : NSObject<NSCopying> {
@private
    Class _objectClass;
    NSMutableDictionary* _properties;
    dispatch_once_t _databaseTablePredicate;
    FLDatabaseTable* _databaseTable;
}
@property (readonly, assign) Class objectClass;
@property (readonly, assign) NSUInteger propertyCount;
@property (readonly, copy) NSDictionary* properties;
@property (readonly, strong) FLDatabaseTable* databaseTable;

+ (id) objectDescriber:(Class) aClass;

// helpers
- (FLPropertyDescriber*) propertyForName:(NSString*) identifier;

// type registration

// NOTE THE METHODS BELOW ARE NOT THREAD SAFE

+ (FLObjectDescriber*) registerClass:(Class) aClass;
- (void) addProperty:(FLPropertyDescriber*) subtype;

// deprecated
- (id) initWithClass:(Class) aClass;
- (void) setChildForIdentifier:(NSString*) name withClass:(Class) objectClass;
- (void) setChildForIdentifier:(NSString*) name withArrayTypes:(NSArray*) types;
@end            

@interface FLAbstractObjectType : NSObject
@end