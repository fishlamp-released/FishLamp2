//
//  FishLampDataTypeID.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/23/12
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCore.h"
#import "FLTypeDesc.h"

#import <objc/runtime.h>

typedef unsigned int FLTypeDescTypeID;

@interface FLTypeDesc : NSObject {
@private
    NSString* _name;
}

- (id) initWithName:(NSString*) name;

@property (readonly, strong, nonatomic) NSString* name;
@property (readonly, assign, nonatomic) Class classForType;

@property (readonly, assign, nonatomic) BOOL isNumber;
@property (readonly, assign, nonatomic) BOOL isObject;

+ (id) registeredTypeForName:(NSString*) string;
+ (void) registerTypeDesc:(FLTypeDesc*) desc;

- (NSString*) objectToString:(id) object withEncoder:(id) encoder;
- (id) stringToObject:(NSString*) object withDecoder:(id) decoder;

@end

@interface FLTypeDesc (OptionalOverrides)
- (void) registerSelf;
@end

#import "FLTypeDesc+Numbers.h"
#import "FLTypeDesc+Objects.h"
#import "FLTypeDesc+BoxedStructs.h"


