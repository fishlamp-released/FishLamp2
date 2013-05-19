//
//  FLObjectDescriber.m
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLObjectDescriber.h"

#import "FLObjcRuntime.h"
#import "FLModelObject.h"
#import "FLDatabase.h"

//#import "FLTrace.h"

@interface FLPropertyDescriber (Internal)
@property (readwrite) NSString* propertyName;
@property (readwrite) FLObjectDescriber* representedObjectDescriber;
@property (readwrite, copy) NSArray* containedTypes;
- (void) addContainedProperty:(FLPropertyDescriber*) property;
- (id) initWithProperty_t:(objc_property_t) property_t;
+ (id) propertyDescriberWithProperty_t:(objc_property_t) property_t;
@end


@interface FLObjectDescriber ()
- (void) addPropertiesForClass:(Class) aClass;
- (id) initWithClass:(Class) aClass;
@property (readwrite, assign) Class objectClass;
@end

@implementation FLObjectDescriber

static NSMutableDictionary* s_registry = nil;

@synthesize objectClass = _objectClass;
@synthesize properties = _properties;

+ (void) initialize {
    if(!s_registry) {
        s_registry = [[NSMutableDictionary alloc] init];
    }
}

- (id) init {
    return [self initWithClass:nil];
}

- (id) initWithClass:(Class) aClass properties:(NSDictionary*) properties {
    FLAssertNotNil(aClass);
	self = [super init];
	if(self) {
        _objectClass = aClass;
        _properties = [properties mutableCopy];
        _databaseTablePredicate = 0;
	}
	return self;
}

- (id) initWithClass:(Class) aClass {
    return [self initWithClass:aClass properties:nil];
}

+ (id) objectDescriber:(Class) aClass {
    FLObjectDescriber* describer = nil;
    @synchronized([self class]) {
        describer = [s_registry objectForKey:NSStringFromClass(aClass)];
    }
    
    if(describer) {
        return describer;
    }

    return [self registerClass:aClass];
}

+ (id) objectDescriber {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_properties release];
    [super dealloc];
}
#endif

- (FLObjectDescriber*) propertyForName:(NSString*) propertyName {
    @synchronized(self) {
        return [_properties objectForKey:propertyName];
    }
}

- (NSDictionary*) properties {
    @synchronized(self) {
        return FLCopyWithAutorelease(_properties);
    }
}

- (NSUInteger) propertyCount {
    @synchronized(self) {
        return [_properties count];
    }
}

- (void) addProperty:(FLPropertyDescriber*) property {
    FLAssertNotNil(property);
    
    if(!_properties) {
        _properties = [[NSMutableDictionary alloc] init];
    }
   
    FLPropertyDescriber* existing = [_properties objectForKey:property.propertyName];
    if(existing) {
        FLTrace(@"replacing property %@ to %@", property.propertyName, NSStringFromClass(self.objectClass));
        existing.representedObjectDescriber = property.representedObjectDescriber;
        existing.containedTypes = property.containedTypes;
    } 
    else {
        FLTrace(@"added property %@ to %@", property.propertyName, NSStringFromClass(self.objectClass));
        [_properties setObject:property forKey:property.propertyName];
    }
}

- (NSString*) description {
    
    FLPrettyString* contained = [FLPrettyString prettyString];
    [contained indent];
    
    for(FLPropertyDescriber* describer in [_properties objectEnumerator]) {
        [contained appendBlankLine];
        [contained appendFormat:@"%@", [describer description]];
    }
    
    return [NSString stringWithFormat:@"%@ %@", NSStringFromClass(self.objectClass), contained.string];
}

- (BOOL) shouldAddProperty:(FLPropertyDescriber*) property {
    return property.representsIvar;
}

- (void) addPropertiesForClass:(Class) aClass {
// do all the properties
    unsigned int propertyCount = 0;
    objc_property_t* propertys = class_copyPropertyList(aClass, &propertyCount);

    FLTrace(@"found %d properties for %@", propertyCount, NSStringFromClass(aClass));

    for(unsigned int i = 0; i < propertyCount; i++) {
    
        FLPropertyDescriber* propertyDescriber = [FLPropertyDescriber propertyDescriberWithProperty_t:propertys[i]];
        if(propertyDescriber && [self shouldAddProperty:propertyDescriber]) {
            [self addProperty:propertyDescriber];
        }
    }

    free(propertys);
}

- (void) addPropertiesForParentClasses:(Class) aClass {
    if([aClass isModelObject]) {
        if(aClass && [aClass respondsToSelector:@selector(objectDescriber)]) {
            FLObjectDescriber* describer = [aClass objectDescriber];
            for(FLPropertyDescriber* property in [describer.properties objectEnumerator]) {
                [self addProperty:property];
            }
        }
    }
}

- (void) describeSelf {
    Class aClass = [self objectClass];
    BOOL isModelObject = [aClass isModelObject];
    if(isModelObject) {
    // do parents first, because we can override them in subclass
        [self addPropertiesForParentClasses:[aClass superclass]];

    // add our discovered properties
        [self addPropertiesForClass:aClass];
    }
}

+ (id) createDescriberForClass:(Class) aClass {
    return [aClass isModelObject] ? 
        FLAutorelease([[FLModelObjectDescriber alloc] initWithClass:aClass]) : 
        FLAutorelease([[FLObjectDescriber alloc] initWithClass:aClass]);
    
}

+ (id) registerClass:(Class) aClass {
    FLTrace(@"Registering %@:", NSStringFromClass(aClass));

    FLObjectDescriber* describer = [[self class] createDescriberForClass:aClass];
    
    @synchronized(self) {
        [s_registry setObject:describer forKey:NSStringFromClass(aClass)];
    }
    [describer describeSelf];

    if([aClass isModelObject]) {    
        [aClass didRegisterObjectDescriber:describer];
    }
    
    return describer;
}

- (id) copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithClass:_objectClass properties:_properties];
}

- (FLDatabaseTable*) databaseTable {
    if([self.objectClass isModelObject]) {
        dispatch_once(&_databaseTablePredicate, ^{ 
            _databaseTable = [[FLDatabaseTable alloc] initWithClass:self.objectClass]; 
        }); 
    }
    return _databaseTable;
}

- (void) addPropertyArrayTypes:(NSArray*) types forPropertyName:(NSString*) name {
    FLPropertyDescriber* property = [self.properties objectForKey:name];
    FLAssertNotNil(property);
   
    if(![property representsClass:[NSMutableArray class]] ) {
        property.representedObjectDescriber  = [FLObjectDescriber objectDescriber:[NSMutableArray class]];
    }
    FLAssertNil(property.containedTypes);
    FLAssertNotNil(types);

    property.containedTypes = types;    
} 

- (void) addContainerType:(FLPropertyDescriber*) subProperty 
     forContainerProperty:(NSString*) propertyName {
    FLPropertyDescriber* property = [self.properties objectForKey:propertyName];
    [property addContainedProperty:subProperty];
}

- (void) addPropertyWithName:(NSString*) name withArrayTypes:(NSArray*) types {
    [self addPropertyArrayTypes:types forPropertyName:name];
}

- (void) addArrayProperty:(NSString*) name withArrayTypes:(NSArray*) types {
    [self addPropertyArrayTypes:types forPropertyName:name];
}
@end

@implementation FLModelObjectDescriber
@end

@implementation FLLegacyObjectDescriber

+ (id) registerClass:(Class) aClass {
    FLAssertFailedWithComment(@"no longer supported");
    return nil;
}

- (id) initWithClass:(Class) aClass {
    return [super initWithClass:aClass];
}

- (void) addPropertyWithName:(NSString*) name withClass:(Class) objectClass {
    FLPropertyDescriber* property = [self.properties objectForKey:name];
    FLAssertNotNil(property);
    
    if(![property representsClass:objectClass]) {
    
//        FLTrace(@"replaced property class %@ with %@", NSStringFromClass(property.propertyClass), NSStringFromClass(objectClass));
        property.representedObjectDescriber = [FLObjectDescriber objectDescriber:objectClass];
    }
}

- (void) addPropertyWithName:(NSString*) name withArrayTypes:(NSArray*) types {
    FLPropertyDescriber* property = [self.properties objectForKey:name];
    FLAssertNotNil(property);
   
    if(![property representsClass:[NSMutableArray class]] ) {
        property.representedObjectDescriber  = [FLObjectDescriber objectDescriber:[NSMutableArray class]];
    }
    FLAssertNil(property.containedTypes);
    FLAssertNotNil(types);

    property.containedTypes = types;    

}        

- (BOOL) shouldAddProperty:(FLPropertyDescriber*) property {
    return property.representsObject && property.representsIvar;
}

+ (id) createDescriberForClass:(Class) aClass {
    return FLAutorelease([[FLLegacyObjectDescriber alloc] initWithClass:aClass]);
}


@end

@implementation FLAbstractObjectType
@end

@implementation NSObject (FLObjectDescriber)
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
}
+ (FLObjectDescriber*) objectDescriber { 
    return [FLObjectDescriber objectDescriber:[self class]]; 
}
- (FLObjectDescriber*) objectDescriber {
    return [[self class] objectDescriber];
}
@end