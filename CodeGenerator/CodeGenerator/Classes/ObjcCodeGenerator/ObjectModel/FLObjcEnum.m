//
//  FLObjcEnum.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcEnum.h"

#import "FLCodeEnumType.h"
#import "FLObjcTypeIndex.h"
#import "FLObjcName.h"
#import "FLCodeEnum.h"

@implementation FLObjcEnum
@synthesize enumType = _enumType;
@synthesize enumValues = _enumValues;
@synthesize enumName = _enumName;

#if FL_MRC
- (void) dealloc {
    [_enumName release];
    [_enumType release];
    [_enumValues release];
	[super dealloc];
}
#endif

- (id) initWithTypeIndex:(FLObjcTypeIndex*) typeIndex {	
	self = [super initWithTypeIndex:typeIndex];
	if(self) {
		_enumValues = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (id) objcEnum:(FLObjcTypeIndex*) typeIndex {
    return FLAutorelease([[[self class] alloc] initWithTypeIndex:typeIndex]);
}

- (void) addValue:(FLObjcEnumValue*) enumValueType {
    [_enumValues addObject:enumValueType];
}

- (void) configureWithCodeEnumType:(FLCodeEnumType*) codeEnumType  {
    self.enumName = [FLObjcEnumName objcEnumName:codeEnumType.typeName prefix:self.typeIndex.classPrefix];

    self.enumType = [FLObjcEnumType objcEnumType:self.enumName importFileName:[NSString stringWithFormat:@"%@.h", self.enumName.generatedName]];
    
    
    for(FLCodeEnum* aEnum in codeEnumType.enums) {
    
        FLObjcEnumValueName* name = [FLObjcEnumValueName objcEnumValueName:aEnum.name prefix:self.enumName.generatedName];
    
        NSString* value = nil;
        if(aEnum.value != 0) {
            value = [NSString stringWithFormat:@"%ld", (long) aEnum.value];
        }
    
        FLObjcEnumValue* enumValue = [FLObjcEnumValue objcEnumValue:name value:value]; 
        [self addValue:enumValue];
    }
}

- (NSString*) generatedName {
    return self.enumName.generatedName;
}

- (NSString*) generatedReference {
    return self.enumType.generatedReference;
}

- (void) writeCodeToHeaderFile:(FLObjcFile*) file 
    withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
    
    [codeBuilder appendLine:@"typedef enum {"];
    [codeBuilder indent:^{
        for(FLObjcEnumValue* value in _enumValues) {
            [codeBuilder appendLineWithFormat:@"%@,", value.generatedName];
         
        } 
    }];
    [codeBuilder appendLineWithFormat:@"} %@;", self.generatedName];
    
}
- (void) writeCodeToSourceFile:(FLObjcFile*) file 
               withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {
}
@end

@implementation FLObjcEnumValue
@synthesize enumValue = _enumValue;
#if FL_MRC
- (void) dealloc {
	[_enumValue release];
	[super dealloc];
}
#endif

- (id) initWithName:(FLObjcName*) name value:(NSString*) value {	
	self = [super initWithTypeName:name importFileName:nil];
	if(self) {
		self.enumValue = value;
	}
	return self;
}

+ (id) objcEnumValue:(FLObjcName*) name value:(NSString*) valueOrNil {
    return FLAutorelease([[[self class] alloc] initWithName:name value:valueOrNil]);
}

@end