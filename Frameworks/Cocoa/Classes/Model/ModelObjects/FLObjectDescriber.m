//
//  FLObjectDescriber.m
//  PackMule
//
//  Created by Mike Fullerton on 6/30/11.
//  Copyright 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLObjectDescriber.h"

#import "FLObjcRuntime.h"
#import "FLPropertyAttributes.h"
#import "FLModelObject.h"
#import "FLDatabase.h"

//#import "FLTrace.h"

@interface FLPropertyDescriber (Internal)
@property (readwrite) NSString* propertyName;
@property (readwrite) FLObjectDescriber* propertyType;
@property (readwrite, copy) NSArray* containedTypes;
@end


@interface FLObjectDescriber ()
//@property (readwrite, assign) Class objectClass;

- (void) addPropertiesForClass:(Class) aClass;
- (id) initWithClass:(Class) aClass;
@end

//@interface FLThreadSafeRef : NSProxy {
//@private
//    id _object;
//}
//@property (readwrite, strong, nonatomic) id object;
//@end
//
//@implementation FLThreadSafeRef 
//
//@synthesize object = _object;
//
//
//- (id) initWithObject:(id) object {	
//	self.object = object;
//	return self;
//}
//
//+ (id) threadSafeRef:(id) object {
//    return FLAutorelease([[[self class] alloc] initWithObject:object]);
//}
//
//- (void)forwardInvocation:(NSInvocation *)invocation {
//    id myObject = self.object;
//    if (myObject ) {
//        [invocation setTarget:myObject];
//        @synchronized(myObject) {
//            [invocation invoke];
//        }
//    }
//}
//
//- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel  {
//    return [self.object methodSignatureForSelector:sel];
//}
//
//#if FL_MRC
//- (void) dealloc {
//	[_object release];
//	[super dealloc];
//}
//#endif
//
//- (BOOL)respondsToSelector:(SEL)aSelector {
//    if([self respondsToSelector:aSelector]) {
//        return YES;
//    }
//
//    return [self.object respondsToSelector:aSelector];
//}
//
//@end

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
	self = [self initWithClass:aClass];
	if(self) {
        _properties = [properties mutableCopy];
        _databaseTablePredicate = 0;
	}
	return self;
}

- (id) initWithClass:(Class) aClass {
    FLAssertNotNil(aClass);
	self = [super init];
	if(self) {
        _objectClass = aClass;
	}
	return self;
}

+ (id) objectDescriber:(Class) aClass {
    FLObjectDescriber* describer = nil;
    @synchronized([self class]) {
        describer = [s_registry objectForKey:NSStringFromClass(aClass)];
    }
    
    if(describer) {
        return describer;
    }

//    if(!describer && [aClass isModelObject]) {
//        return [aClass objectDescriber];
//    }
//    else {
        return [self registerClass:aClass];
//    }
        
    return nil;
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
        existing.propertyType = property.propertyType;
        existing.containedTypes = property.containedTypes;
    } 
    else {
        FLTrace(@"added property %@ to %@", property.propertyName, NSStringFromClass(self.objectClass));
        [_properties setObject:property forKey:property.propertyName];
    }
}

//- (void) setPropertyClass:(Class) aClass forIdentifier:(NSString*) propertyName {
//    [self addProperty:[FLPropertyDescriber propertyDescriber:propertyName class:aClass]];
//}

//- (void) setSubtypeArrayTypes:(NSArray*) arrayTypes forIdentifier:(NSString*) propertyName {
//    FLPropertyDescriber* objectDescriber = [FLPropertyDescriber propertyDescriber:propertyName class:[NSMutableArray class]];
//
////    for(FLObjectDescriber* desc in arrayTypes) {
////        [objectDescriber addProperty:desc];
////    }
//
//    [self addProperty:objectDescriber];
//}

//- (void) describeTo:(FLPrettyString*) string

- (NSString*) description {
    
    FLPrettyString* contained = [FLPrettyString prettyString];
    [contained indent];
    
    for(FLPropertyDescriber* describer in [_properties objectEnumerator]) {
        [contained appendBlankLine];
        [contained appendFormat:@"%@", [describer description]];
    }
    
    return [NSString stringWithFormat:@"%@ %@", NSStringFromClass(self.objectClass), contained.string];
}

+ (id) createWithRuntimeProperty:(objc_property_t) runtimeProperty {

    FLPropertyAttributes_t attributes;
    FLPropertyAttributesDecodeWithNoCopy(runtimeProperty, &attributes);
    
    if(attributes.propertyName) {

        if(attributes.is_object) {
            FLTrace(@"adding object property \"%s\" (%s)", attributes.propertyName, attributes.encodedAttributes);

            NSString* propertyName = [NSString stringWithCString:attributes.propertyName encoding:NSASCIIStringEncoding];
            Class objectClass = nil;
            
            if(attributes.className.string) {
                objectClass = NSClassFromString([NSString stringWithCharString:attributes.className]);
            }
            else {
                objectClass = [FLAbstractObjectType class];
            }

            return [FLPropertyDescriber propertyDescriber:propertyName propertyClass:objectClass];
        }
        else {
            FLTrace(@"skipping property: %s (%s)", attributes.propertyName, attributes.encodedAttributes);
        }
    }

    return nil;
}

- (void) addPropertiesForClass:(Class) aClass {
// do all the properties
    unsigned int propertyCount = 0;
    objc_property_t* propertys = class_copyPropertyList(aClass, &propertyCount);

    FLTrace(@"found %d properties for %@", propertyCount, NSStringFromClass(aClass));

    for(unsigned int i = 0; i < propertyCount; i++) {
    
        FLPropertyDescriber* propertyDescriber = [FLObjectDescriber createWithRuntimeProperty:propertys[i]];
        if(propertyDescriber) {
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

+ (FLObjectDescriber*) registerClass:(Class) aClass {
    FLTrace(@"Registering %@:", NSStringFromClass(aClass));

    FLObjectDescriber* describer = FLAutorelease([[[self class] alloc] initWithClass:aClass]);;

    BOOL isModelObject = [aClass isModelObject];
    if(isModelObject) {
    // do parents first, because we can override them in subclass
        [describer addPropertiesForParentClasses:[aClass superclass]];

    // add our discovered properties
        [describer addPropertiesForClass:aClass];
    }
    
    @synchronized(self) {
        [s_registry setObject:describer forKey:NSStringFromClass(aClass)];
    }
    if(isModelObject) {    
        [aClass modelObjectWasRegistered:describer];
    }
    
    return describer;
}

- (void) setChildForIdentifier:(NSString*) name withClass:(Class) objectClass {
    FLPropertyDescriber* property = [_properties objectForKey:name];
    FLAssertNotNil(property);
    
    if(property.propertyClass != objectClass) {
    
        FLTrace(@"replaced property class %@ with %@", NSStringFromClass(property.propertyClass), NSStringFromClass(objectClass));
        property.propertyType = [FLObjectDescriber objectDescriber:objectClass];
        
//        [_properties setObject:[FLPropertyDescriber propertyDescriber:name propertyClass:objectClass] forKey:name];
    }
}

- (void) setChildForIdentifier:(NSString*) name withArrayTypes:(NSArray*) types {
    FLPropertyDescriber* property = [_properties objectForKey:name];
    FLAssertNotNil(property);
   
    if(property.propertyClass != [NSMutableArray class]) {
        property.propertyType  = [FLObjectDescriber objectDescriber:[NSMutableArray class]];
    }
    FLAssertNil(property.containedTypes);
    FLAssertNotNil(types);

    property.containedTypes = types;    
}        


- (id) copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] initWithClass:_objectClass properties:_properties];
}

- (FLDatabaseTable*) databaseTable {
    if([self.objectClass isModelObject]) {
        dispatch_once(&_databaseTablePredicate, ^{ 
            _databaseTable = [[FLDatabaseTable alloc] initWithClass:[self class]]; 
        }); 
    }
    return _databaseTable;
}


@end
@implementation FLAbstractObjectType
@end

@implementation NSObject (FLObjectDescriber)
+ (void) modelObjectWasRegistered:(FLObjectDescriber*) describer {
}
+ (FLObjectDescriber*) objectDescriber { 
    return [FLObjectDescriber objectDescriber:[self class]]; 
}
- (FLObjectDescriber*) objectDescriber {
    return [[self class] objectDescriber];
}
@end
