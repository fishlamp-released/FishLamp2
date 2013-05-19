

//
//  FLObjectDescriber.h
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLamp.h"
#import "FLPropertyDescriber.h"
#import "FLDatabase.h"

@class FLStringEncoder;
@class FLObjectDescriber;

@interface NSObject (FLObjectDescriber)
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer;
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

+ (id) registerClass:(Class) aClass;
- (void) addProperty:(FLPropertyDescriber*) subtype;

- (void) addPropertyArrayTypes:(NSArray*) arrayTypes forPropertyName:(NSString*) propertyName;


// deprected
- (void) addPropertyWithName:(NSString*) name withArrayTypes:(NSArray*) types;
- (void) addArrayProperty:(NSString*) name withArrayTypes:(NSArray*) types;
@end            

@interface FLModelObjectDescriber : FLObjectDescriber
@end

@interface FLLegacyObjectDescriber : FLModelObjectDescriber
//- (id) initWithClass:(Class) aClass;
- (void) addPropertyWithName:(NSString*) name withClass:(Class) objectClass;
- (void) addPropertyWithName:(NSString*) name withArrayTypes:(NSArray*) types;
@end


@interface FLAbstractObjectType : NSObject
@end
