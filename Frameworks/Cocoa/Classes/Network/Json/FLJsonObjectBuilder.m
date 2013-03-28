//
//  FLJsonObjectBuilder.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLJsonObjectBuilder.h"
#import "FLBase64Encoding.h"
#import "FLDataEncoder.h"
#import "FLObjectDescriber.h"
#import "FLObjectDescriber.h"

@interface FLJsonObjectBuilder ()
- (id) objectFromJSON:(id) jsonObject withObjectType:(FLObjectDescriber*) type;
@end

@implementation NSString (FLJsonObjectBuilder)

- (id) objectWithJsonObjectBuilder:(FLJsonObjectBuilder*) builder withDescription:(FLObjectDescriber*) objectDescription {
    FLAssertNotNil(builder);
    FLAssertNotNil(objectDescription);
    
    FLObjectEncoder* decoder = objectDescription.objectEncoder;
    if(decoder) {
        FLAssertNotNil(builder.decoder);

        return [decoder decodeStringToObject:self withDecoder:builder.decoder];
    }
    else {
        FLLog(@"Json property %@ has no encoder", objectDescription.objectName);
    }

    return nil;
}

@end

@implementation NSNumber (FLJsonObjectBuilder)
- (id) objectWithJsonObjectBuilder:(FLJsonObjectBuilder*) builder withDescription:(FLObjectDescriber*) objectDescription {
    return self;
}
@end

@implementation NSDictionary (FLJsonObjectBuilder)

- (id) objectWithJsonObjectBuilder:(FLJsonObjectBuilder*) builder withDescription:(FLObjectDescriber*) describer {
    FLAssertNotNil(builder);
    FLAssertNotNil(describer);

//    if(!FLStringsAreEqual(jsonDictionary.jsonObjectName, objectDescription.objectName)) {
//        id subElement = [jsonDictionary jsonObjectForElementName:objectDescription.objectName];
//
//        if(!subElement) {
//            FLThrowErrorCodeWithComment(NSCocoaErrorDomain, NSFileNoSuchFileError, @"XmlObjectBuilder: \"%@\" not found in \"%@\"", objectDescription.objectName, jsonDictionary.jsonObjectName);
//        }
//        
//        jsonDictionary = subElement;
//    }
//
//    FLAssertWithComment(FLStringsAreEqual(jsonDictionary.key, objectDescription.objectName), @"trying to build wrong object jsonDictionary name: \"%@\", object describer name: \"%@\"", jsonDictionary.key, objectDescription.objectName);

    Class objectClass = describer.objectClass;
    if(!objectClass) {
        FLLog(@"Object description has nil object class: %@", [describer description]);
        return nil;
    }
    
    describer = [objectClass objectDescriber];

    id rootObject = FLAutorelease([[objectClass alloc] init]);
    FLAssertNotNilWithComment(rootObject, @"unable to create object of type: %@", NSStringFromClass(objectClass));
    
    for(id key in self) {
        id value = [self objectForKey:key];

        FLObjectDescriber* childDescription = [describer.properties objectForKey:key];
        if(!childDescription) {
            FLLog(@"object builder skipped missing objectDescription named: %@", key);
            continue;
        }
        
        id object = [value objectWithJsonObjectBuilder:builder withDescription:childDescription];
        FLAssertNotNil(object);
        [rootObject setValue:object forKey:key];
    }
    return rootObject;
}

// I'm not sure this makes any sense at all... ????
- (NSArray*) objectArrayWithJsonObjectBuilder:(FLJsonObjectBuilder*) builder withObjectTypes:(NSArray*) arrayOfObjectDescribers {

    FLAssertionFailedWithComment(@"array from dictinary for JSON object makes no sense");
    
    return nil;
}

@end

@implementation NSArray (FLJsonObjectBuilder)

- (NSArray*) objectArrayWithJsonObjectBuilder:(FLJsonObjectBuilder*) builder withObjectTypes:(NSArray*) arrayOfObjectDescribers {

// TODO: handle hetrogenous arrays
    FLObjectDescriber* objectDescription = [arrayOfObjectDescribers firstObject];

    NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:self.count];
    for(id child in self) {	
    
// TODO: we need a way of choosing the type. We'll have to add a way to associate a property like "type" with the type??            
                    		
        [newArray addObject:[builder objectFromJSON:child withObjectType:objectDescription]];
    }

    return newArray;
}

- (id) objectWithJsonObjectBuilder:(FLJsonObjectBuilder*) builder withDescription:(FLObjectDescriber*) objectDescription {

    NSMutableArray* newArray = [NSMutableArray arrayWithCapacity:self.count];
    for(id child in self) {			
        [newArray addObject:[builder objectFromJSON:child withObjectType:objectDescription]];
    }

    return newArray;

}


@end


@implementation FLJsonObjectBuilder

@synthesize decoder = _decoder;

- (id) init {
    return [self initWithDataDecoder:[FLDataEncoder dataEncoder]];
}

- (id) initWithDataDecoder:(id<FLDataDecoding>) decoder {
    self = [super init];
    if(self) {
        _decoder = FLRetain(decoder);
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_decoder release];
    [super dealloc];
}
#endif

+ (id) jsonObjectBuilder:(id<FLDataDecoding>) decoder {
    return FLAutorelease([[[self class] alloc] initWithDataDecoder:decoder]);
}

+ (id) jsonObjectBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSArray*) arrayOfObjectsFromJSON:(id) jsonObject withObjectTypes:(NSArray*) arrayOfObjectDescriber {
    return [jsonObject objectArrayWithJsonObjectBuilder:self withObjectTypes: arrayOfObjectDescriber];
}

- (NSArray*) arrayOfObjectsFromJSON:(id) json withObjectType:(FLObjectDescriber*) type {
    return [self arrayOfObjectsFromJSON:json withObjectTypes:[NSArray arrayWithObject:type]];
}

- (id) objectFromJSON:(id) jsonObject withObjectType:(FLObjectDescriber*) type {
    return [jsonObject objectWithJsonObjectBuilder:self withDescription:type];
}

- (NSArray*) arrayOfObjectsFromJSON:(id) json expectedRootObjectClass:(Class) aClass {
    return [self arrayOfObjectsFromJSON:json withObjectTypes:[NSArray arrayWithObject:[aClass objectDescriber]]];
}

- (id) objectFromJSON:(id) parsedJson expectedRootObjectClass:(Class) type {
    return [parsedJson objectWithJsonObjectBuilder:self withDescription:[type objectDescriber]];
}

@end




