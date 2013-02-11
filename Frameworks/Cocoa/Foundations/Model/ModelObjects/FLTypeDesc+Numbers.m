//
//  FLTypeDesc+Numbers.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTypeDesc.h"

@implementation FLTypeDesc (Numbers)
+ (id) boolType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"bool" numberType:FLTypeDescBool]);
}
+ (id) charType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"char" numberType:FLTypeDescChar]);
}
+ (id) unsignedCharType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"unsignedChar" numberType:FLTypeDescUnsignedChar]);
}
+ (id) shortType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"short" numberType:FLTypeDescShort]);
}
+ (id) unsignedShortType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"unsignedShort" numberType:FLTypeDescUnsignedShort]);
}
+ (id) intType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"int" numberType:FLTypeDescInt]);
}
+ (id) unsignedIntType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"unsignedInt" numberType:FLTypeDescUnsignedInt]);
}
+ (id) longType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"long" numberType:FLTypeDescLong]);
}
+ (id) unsignedLongType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"unsignedLong" numberType:FLTypeDescUnsignedLong]);
}
+ (id) longLongType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"longLong" numberType:FLTypeDescLongLong]);
}
+ (id) unsignedLongLongType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"unsignedLongLong" numberType:FLTypeDescUnsignedLongLong]);
}
+ (id) floatType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"float" numberType:FLTypeDescFloat]);
}
+ (id) doubleType {
    FLReturnStaticObject([[FLNumberTypeDesc alloc] initWithName:@"double" numberType:FLTypeDescDouble]);
}
+ (id) enumType {
    FLReturnStaticObject([[FLEnumTypeDesc alloc] initWithName:@"enum" numberType:FLTypeDescEnum]);
}
@end

@implementation FLNumberTypeDesc

@synthesize numberType = _numberType;

- (id) initWithName:(NSString*) name numberType:(FLTypeDescNumberType) numberType {

    self = [super initWithName:name];
    if(self) {
        _numberType = numberType;
    }

    return self;
}

- (BOOL) isNumber {
    return YES;
}
- (BOOL) isObject {
    return NO;
}

- (Class) classForType {
    return [NSNumber class];
}

//- (SEL) valueSelector {
//}
//
//- (SEL) instanceInitSelector {
//}
//
//- (SEL) classInitSelector {
//}
//


- (NSString*) objectToString:(id) object withEncoder:(id) encoder {
    return [encoder encodeStringWithNumber:object];
}

- (id) stringToObject:(NSString*) string withDecoder:(id) decoder {
    return [decoder decodeNumberFromString:string];
}

@end



