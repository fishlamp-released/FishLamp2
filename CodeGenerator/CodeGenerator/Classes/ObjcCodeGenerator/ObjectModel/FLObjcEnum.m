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
#import "FLObjcCodeBuilder.h"
#import "FLTypeSpecificEnumSet.h"

@implementation FLObjcEnum
@synthesize enumType = _enumType;
@synthesize enumValues = _enumValues;
@synthesize enumName = _enumName;

- (id) initWithTypeIndex:(FLObjcTypeIndex*) typeIndex {	
	self = [super initWithTypeIndex:typeIndex];
	if(self) {
		_enumValues = [[NSMutableArray alloc] init];
        _defines = [[NSMutableDictionary alloc] init];
	}
	return self;
}


#if FL_MRC
- (void) dealloc {
    [_enumName release];
    [_enumType release];
    [_enumValues release];
    [_defines release];
	[super dealloc];
}
#endif


+ (id) objcEnum:(FLObjcTypeIndex*) typeIndex {
    return FLAutorelease([[[self class] alloc] initWithTypeIndex:typeIndex]);
}

- (void) addValue:(FLObjcEnumValue*) enumValueType {
    [_enumValues addObject:enumValueType];
}


- (void) configureWithCodeEnumType:(FLCodeEnumType*) codeEnumType  {
    self.enumName = [FLObjcEnumName objcEnumName:codeEnumType.typeName prefix:self.typeIndex.classPrefix];

    self.enumType = [FLObjcEnumType objcEnumType:self.enumName importFileName:[NSString stringWithFormat:@"%@.h", self.enumName.generatedName]];
    
    NSInteger counter = -1;
    for(FLCodeEnum* aEnum in codeEnumType.enums) {
    
        FLObjcEnumValueName* name = [FLObjcEnumValueName objcEnumValueName:aEnum.name prefix:self.enumName.generatedName];
    
        [_defines setObject:aEnum.name forKey:name.generatedName];
    
        NSString* value = nil;
        if(aEnum.value != 0) {
            value = aEnum.value;
        }
        else {
            value = ++counter;
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
    
    [codeBuilder appendImport:NSStringFromClass([FLTypeSpecificEnumSet class])];
    [codeBuilder appendBlankLine];
    
    [codeBuilder appendLine:@"typedef enum {"];
    [codeBuilder indent:^{
        for(FLObjcEnumValue* value in _enumValues) {
            [codeBuilder appendLineWithFormat:@"%@ = %ld,", value.generatedName, value.enumValue];
         
        } 
    }];
    [codeBuilder appendLineWithFormat:@"} %@;", self.generatedName];
    
    [codeBuilder appendBlankLine];
    for(NSString* define in _defines) {
        [codeBuilder appendDefine:[NSString stringWithFormat:@"k%@", define] stringValue:[_defines objectForKey:define]];
    }
    [codeBuilder appendBlankLine];

// TODO: abstract this
    [codeBuilder appendLineWithFormat:@"extern NSString* %@StringFromEnum(%@ theEnum);", self.enumType.generatedName, self.enumType.generatedName];
    [codeBuilder appendLineWithFormat:@"extern %@ %@EnumFromString(NSString* theString);", self.enumType.generatedName, self.enumType.generatedName];
    
    
    [codeBuilder appendBlankLine];

    NSString* className = [NSString stringWithFormat:@"%@EnumSet", self.enumType.generatedName];

    [codeBuilder appendInterfaceDeclaration:className
                                 superClass:NSStringFromClass([FLTypeSpecificEnumSet class]) 
                                  protocols:nil appendMemberDeclarations:nil];

    [codeBuilder appendMethodDeclaration:@"enumSet" type:@"id" isInstanceMethod:NO closeLine:YES];
    
    [codeBuilder appendEnd];
                                  
    
    
}
- (void) writeCodeToSourceFile:(FLObjcFile*) file 
               withCodeBuilder:(FLObjcCodeBuilder*) codeBuilder {

    [codeBuilder appendImport:self.enumType.generatedName];
    [codeBuilder appendBlankLine];
               
    [codeBuilder appendLineWithFormat:@"NSString* %@StringFromEnum(%@ theEnum) {", self.enumType.generatedName, self.enumType.generatedName];
    [codeBuilder indent: ^{
        [codeBuilder appendSwitchBlock:@"theEnum" caseStatements:^{
            for(NSString* define in _defines) {
                [codeBuilder appendCaseStatement:define statement:^{
                    [codeBuilder appendReturnValue:[NSString stringWithFormat:@"k%@", define]];
                }];
            }
        }];
        
        [codeBuilder appendReturnValue:@"nil"];
    }];
    [codeBuilder appendLine:@"}"];
    [codeBuilder appendBlankLine];

    [codeBuilder appendLineWithFormat:@"%@ %@EnumFromString(NSString* theString) {", self.enumType.generatedName, self.enumType.generatedName];
    [codeBuilder indent: ^{
        [codeBuilder appendStaticVariable:@"NSDictionary*" name:@"s_enumLookup" initialValue:@"nil"];
        [codeBuilder appendRunOnceBlock:@"s_lookupPredicate" block:^{
            [codeBuilder appendLineWithFormat:@"s_enumLookup = [[NSDictionary alloc] initWithObjectsAndKeys:"];
            [codeBuilder indent:^{
                for(NSString* define in _defines) {
                    [codeBuilder appendLineWithFormat:@"[NSNumber numberWithInteger:%@], [k%@ lowercaseString],", define, define]; 
                }
                
                [codeBuilder appendLine:@"nil ];"];
            }];
        
        }];

        [codeBuilder appendLineWithFormat:@"NSNumber* value = [s_enumLookup objectForKey:[theString lowercaseString]];"];
        [codeBuilder appendReturnValue:@"value == nil ? NSNotFound : [value integerValue]"];
        
    }];
    [codeBuilder appendLine:@"}"];
               
    [codeBuilder appendBlankLine];
    
    NSString* className = [NSString stringWithFormat:@"%@EnumSet", self.enumType.generatedName];
    
    [codeBuilder appendImplementation:className];
    [codeBuilder appendMethodDeclaration:@"enumSet" type:@"id" isInstanceMethod:NO closeLine:NO];
    [codeBuilder scope:^{
        [codeBuilder appendReturnValue:[NSString stringWithFormat:@"FLAutorelease([[[self class] alloc] initWithValueLookup:(FLEnumSetEnumValueLookup*)  %@EnumFromString stringLookup:(FLEnumSetEnumStringLookup*) %@StringFromEnum])", self.enumType.generatedName, self.enumType.generatedName]];
    }];
    [codeBuilder appendEnd];


}
@end

@implementation FLObjcEnumValue
@synthesize enumValue = _enumValue;
#if FL_MRC
- (void) dealloc {
//	[_enumValue release];
	[super dealloc];
}
#endif

- (id) initWithName:(FLObjcName*) name value:(NSUInteger) value {	
	self = [super initWithTypeName:name importFileName:nil];
	if(self) {
		self.enumValue = value;
	}
	return self;
}

+ (id) objcEnumValue:(FLObjcName*) name value:(NSUInteger) value {
    return FLAutorelease([[[self class] alloc] initWithName:name value:value]);
}

@end