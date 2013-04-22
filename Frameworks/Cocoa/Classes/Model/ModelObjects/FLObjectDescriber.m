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
#import "FLOrderedCollection.h"
#import "FLModelObject.h"

#import "FLTrace.h"

@interface FLObjectDescriber ()
- (void) addPropertiesForClass:(Class) aClass;

@property (readwrite, assign) Class objectClass;
@property (readwrite, strong) NSString* identifier;
@property (readwrite, strong) FLObjectEncoder* objectEncoder;

- (id) initWithClass:(Class) aClass;
- (id) initWithIdentifier:(NSString*) identifier class:(Class) aClass;

@end

@implementation FLObjectDescriber

static NSMutableDictionary* s_registry = nil;

@synthesize identifier = _identifier;
@synthesize objectClass = _objectClass;
@synthesize objectEncoder = _objectEncoder;

+ (void) initialize {
    if(!s_registry) {
        s_registry = [[NSMutableDictionary alloc] init];
    }
}

- (id) init {
    return [self initWithIdentifier:nil class:nil];
}

- (id) initWithClass:(Class) aClass {
    return [self initWithIdentifier:nil class:aClass];
}

- (id) initWithIdentifier:(NSString*) identifier class:(Class) aClass {	

    FLAssertNotNil(aClass);
	self = [super init];
	if(self) {
        self.objectClass = aClass;
        self.identifier = identifier;
	}
	return self;
}

- (id) initInternal {
    self = [super init];
    if(self) {
    }
    return self;
}

+ (id) objectDescriber:(Class) aClass {
    FLObjectDescriber* describer = nil;
    @synchronized([self class]) {
        describer = [s_registry objectForKey:NSStringFromClass(aClass)];
    }
    if(!describer && [aClass isModelObject]) {
        describer = [aClass objectDescriber];
    }
        
    return describer;
}

+ (id) objectDescriber:(NSString*) identifier class:(Class) aClass {
    return FLAutorelease([[[self class] alloc] initWithIdentifier:identifier class:aClass]);
}

#if FL_MRC
- (void) dealloc {
    [_objectEncoder release];
    [_subtypes release];
	[_identifier release];
    [super dealloc];
}
#endif

- (FLObjectDescriber*) subTypeForIdentifier:(NSString*) identifier {
    @synchronized(self) {
        return [_subtypes objectForKey:identifier];
    }
}

- (FLObjectDescriber*) subTypeForIndex:(NSUInteger) idx {
    @synchronized(self) {
        return [_subtypes objectAtIndex:idx];
    }
}

- (NSString*) identifierForIndex:(NSUInteger) idx {
    @synchronized(self) {
        return [_subtypes keyAtIndex:idx];
    }
}

- (NSUInteger) subTypeCount {
    @synchronized(self) {
        return [_subtypes count];
    }
}

- (void) addSubtype:(FLObjectDescriber*) subtype {
    FLAssertNotNil(subtype);
    
    if(!_subtypes) {
        _subtypes = [[FLOrderedCollection alloc] init];
    }
    
    if(subtype.objectClass) {
        [_subtypes setObject:subtype forKey:subtype.identifier];
    }
#if TRACE    
    else {
        FLLog(@"skipping property %@", subtype.identifier);
    }
#endif   
}

- (void) setSubtypeClass:(Class) aClass forIdentifier:(NSString*) identifier {
    [self addSubtype:[FLObjectDescriber objectDescriber:identifier class:aClass]];
}

- (void) setSubtypeArrayTypes:(NSArray*) arrayTypes forIdentifier:(NSString*) identifier {
    FLObjectDescriber* objectDescriber = [FLObjectDescriber objectDescriber:identifier class:[NSMutableArray class]];

    for(FLObjectDescriber* desc in arrayTypes) {
        [objectDescriber addSubtype:desc];
    }

    [self addSubtype:objectDescriber];
}

- (NSString*) description {
	return [NSString stringWithFormat:@"%@: { class=%@, subtypes:%@", [super description], NSStringFromClass(self.objectClass), [_subtypes description]];
}

+ (id) createWithRuntimeProperty:(objc_property_t) runtimeProperty {

    FLPropertyAttributes_t attributes;
    FLPropertyAttributesDecodeWithNoCopy(runtimeProperty, &attributes);
    
    if(attributes.className.string) {
        NSString* identifier = [NSString stringWithCString:attributes.propertyName encoding:NSASCIIStringEncoding];
        Class objectClass = NSClassFromString([NSString stringWithCharString:attributes.className]);
        return [FLObjectDescriber objectDescriber:identifier class:objectClass];
    }
    
//    FLTrace(@"unable to make object objectDescriber for %s", attributes.encodedAttributes);
    return nil;
}

- (void) addPropertiesForClass:(Class) aClass {
    if(aClass && [aClass respondsToSelector:@selector(objectDescriber)]) {

// do parents first, because we can override them in subclass
        [self addPropertiesForClass:[aClass superclass]];

// do all the properties
        unsigned int propertyCount = 0;
        objc_property_t* subtypes = class_copyPropertyList(aClass, &propertyCount);

        FLTrace(@"adding %d properties for %@", propertyCount, NSStringFromClass(aClass));

        for(unsigned int i = 0; i < propertyCount; i++) {
        
            FLObjectDescriber* objectDescriber = [FLObjectDescriber createWithRuntimeProperty:subtypes[i]];
            if(objectDescriber) {
                [self addSubtype:objectDescriber];
            }
        }

        free(subtypes);
    }
}

+ (void) registerClass:(Class) aClass {
    FLObjectDescriber* describer = FLAutorelease([[[self class] alloc] initInternal]);;
    describer.objectClass = aClass;
    describer.objectEncoder = [aClass objectEncoder];
    [describer addPropertiesForClass:aClass];
    
    @synchronized(self) {
        [s_registry setObject:describer forKey:NSStringFromClass(aClass)];
    }
}

- (void) setChildForIdentifier:(NSString*) name withClass:(Class) objectClass {
    [self setSubtypeClass:objectClass forIdentifier:name];
}

- (void) setChildForIdentifier:(NSString*) name withArrayTypes:(NSArray*) types {
    [self setSubtypeArrayTypes:types forIdentifier:name];
}

- (NSArray*) subTypesCopy {
    @synchronized(self) {
        return FLAutorelease([_subtypes copy]);
    }
}

@end

@implementation NSObject (FLObjectDescriber)

//+ (FLObjectDescriber*) objectDescriber {
//    return nil;
//}
//
//- (FLObjectDescriber*) objectDescriber {
//    return [[self class] objectDescriber];
//}

+ (void) objectDescriberWasCreated:(FLObjectDescriber*) describer {
}


@end
