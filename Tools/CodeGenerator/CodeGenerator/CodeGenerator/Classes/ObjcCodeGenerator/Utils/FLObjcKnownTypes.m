//
//  FLObjcKnownTypes.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 5/11/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcKnownTypes.h"
#import "FLObjcType.h"
#import "FLObjcName.h"
#import "FLObjcCodeGeneratorHeaders.h"

// TODO: load these in from a file or something more configable than a .m file

@implementation FLObjcKnownTypes

+ (NSDictionary*) knownTypeAliases {
    return [NSDictionary dictionaryWithObjectsAndKeys:
         @"FLGuid",@"guid", 
         @"NSDate" ,@"date", 
         @"NSDate" ,@"datetime", 
         @"NSDate" ,@"time", 
         @"NSString" ,@"string", 
         @"NSNumber" ,@"number", 
         @"BOOL",@"boolean", 
         @"int", @"integer", 
         @"SDKPoint", @"point", 
         @"SDKRect", @"rect", 
         @"SDKSize", @"size",
         @"NSMutableArray", @"array",
         @"NSMutableArray", @"mutablearray",
         @"NSMutableDictionary", @"dictionary",
		 @"unsigned int", @"unsignedint",
		 @"unsigned int", @"unsigned",
         @"id", @"object",

// TODO: abstract this.
         @"NSData", @"base64binary",
         nil];
}

+ (NSArray*) loadKnownTypes {

// TODO: load these in in a file loaded at runtime.

    typedef struct {
        __unsafe_unretained NSString* objcType;
        __unsafe_unretained NSString* name;
        __unsafe_unretained NSString* include;
    } FLTypeHeader;

	static FLTypeHeader s_knownTypes[] = {
// objects
		{ @"FLObjcObjectType", @"NSObject", nil },
		{ @"FLObjcObjectType", @"NSValue", nil },
		{ @"FLObjcObjectType", @"NSDate", nil },
		{ @"FLObjcObjectType", @"NSData", nil },
		{ @"FLObjcObjectType", @"NSString", nil },

		{ @"FLObjcProtocolType", @"NSCoder", nil },

		{ @"FLObjcNumberObjectType", nil, nil },

		{ @"FLObjcContainerType", @"NSMutableArray", nil },
		{ @"FLObjcContainerType", @"NSArray", nil },
		{ @"FLObjcContainerType", @"NSDictionary", nil },
		{ @"FLObjcContainerType", @"NSMutableDictionary", nil },
		{ @"FLObjcContainerType", @"NSSet", nil },
		{ @"FLObjcContainerType", @"NSMutableSet", nil },
		{ @"FLObjcContainerType", @"NSCountedSet", nil },

        { @"FLObjcObjectType", @"UIColor", nil },
        { @"FLObjcObjectType", @"NSColor", nil },
        { @"FLObjcObjectType", @"SDKColor", nil },
        { @"FLObjcObjectType", @"NSURL", nil },

		{ @"FLObjcObjectType", @"NSZone", nil },

// values
		{ @"FLObjcNumberValueType", @"char", nil },
		{ @"FLObjcNumberValueType", @"unsigned char", nil },
		{ @"FLObjcNumberValueType", @"int",nil },
		{ @"FLObjcNumberValueType", @"NSInteger", nil },
		{ @"FLObjcNumberValueType", @"NSUInteger", nil },
		{ @"FLObjcNumberValueType", @"unsigned int", nil },
		{ @"FLObjcNumberValueType", @"UInt32", nil },
		{ @"FLObjcNumberValueType", @"Int32", nil },
		{ @"FLObjcNumberValueType", @"SInt32", nil },
		{ @"FLObjcNumberValueType", @"long", nil },
		{ @"FLObjcNumberValueType", @"unsigned long", nil },
		{ @"FLObjcNumberValueType", @"long long", nil },
		{ @"FLObjcNumberValueType", @"unsigned long long", nil },
		{ @"FLObjcNumberValueType", @"short", nil },
		{ @"FLObjcNumberValueType", @"unsigned short", nil },
		{ @"FLObjcNumberValueType", @"float", nil },
		{ @"FLObjcNumberValueType", @"decimal", nil },
		{ @"FLObjcNumberValueType", @"double", nil },
//		{ @"FLObjcEnumType",        @"enum", nil },
		

		{ @"FLObjcGeometryType", @"CGPoint", nil },
		{ @"FLObjcGeometryType", @"CGRect", nil },
		{ @"FLObjcGeometryType", @"CGSize", nil },
		{ @"FLObjcGeometryType", @"SDKPoint", nil },
		{ @"FLObjcGeometryType", @"SDKRect", nil },
		{ @"FLObjcGeometryType", @"SDKSize", nil },
        { @"FLObjcGeometryType", @"NSPoint", nil },
		{ @"FLObjcGeometryType", @"NSRect", nil },
		{ @"FLObjcGeometryType", @"NSSize", nil },
        
        { @"FLObjcBoolType", @"BOOL", nil },
        { @"FLObjcVoidType", @"void", nil },
		{ @"FLObjcAbstractObjectType", @"id", nil },
        
// fishlamp
        { @"FLObjcObjectType", @"FLDatabaseTable", @"FLDatabaseTable.h" },
		{ @"FLObjcObjectType", @"FLObjectDescriber", @"FLObjectDescriber.h" },
		{ @"FLObjcObjectType", @"FLModelObject", @"FLModelObject.h" },
		{ @"FLObjcObjectType", @"FLGuid", @"FLGuid.h" },
        
        { @"FLObjcProtocolType", @"FLHttpRequestDescriptor", @"FLHttpRequestDescriptor.h" },
        
        { @"FLObjcProtocolType", @"NSCopying", nil },
        { @"FLObjcProtocolType", @"NSCoding", nil },
        
        { nil, nil, nil }
	};
    
    NSMutableArray* array = [NSMutableArray array];
    for(int i = 0; s_knownTypes[i].objcType != nil; i++) {

        FLObjcType* type = nil;
        Class class = NSClassFromString(s_knownTypes[i].objcType);
        FLAssertNotNilWithComment(class, @"unable to load class %@", s_knownTypes[i].objcType);
        
        if(s_knownTypes[i].name) {
            FLObjcName* name = [FLObjcImportedName objcImportedName:s_knownTypes[i].name];
            
            type = FLAutorelease([[class alloc] initWithTypeName:name importFileName:s_knownTypes[i].include]);
        }
        else {
            type = FLAutorelease([[class alloc] init]);
        }
        
        FLAssertNotNilWithComment(class, @"unable to load class %@", s_knownTypes[i].objcType);
        
        
        [array addObject:type];
    }
    
    return array;
}




@end
