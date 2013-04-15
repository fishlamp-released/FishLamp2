//
//  FLTypeDesc.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCoreTypes.h"
#import "FLObjectEncoder.h"

@interface FLTypeDesc : NSObject {
@private
    Class _objectClass;
    NSString* _identifier;
    NSMutableDictionary* _subtypes;
    FLObjectEncoder* _objectEncoder;
}

@property (readwrite, assign, nonatomic) Class objectClass;
@property (readwrite, strong, nonatomic) NSString* identifier;
@property (readwrite, strong, nonatomic) NSDictionary* subtypes;
@property (readwrite, strong, nonatomic) FLObjectEncoder* objectEncoder;

- (id) initWithClass:(Class) aClass;
- (id) initWithIdentifier:(NSString*) identifier class:(Class) aClass;

+ (id) typeDesc:(Class) class;
+ (id) typeDesc:(NSString*) identifier class:(Class) aClass;

- (FLTypeDesc*) subTypeForIdentifier:(NSString*) identifier;

- (void) setSubtypeClass:(Class) aClass forIdentifier:(NSString*) identifier;
- (void) setSubtypeArrayTypes:(NSArray*) arrayTypes forIdentifier:(NSString*) identifier;
- (void) addSubtype:(FLTypeDesc*) subtype;

@end