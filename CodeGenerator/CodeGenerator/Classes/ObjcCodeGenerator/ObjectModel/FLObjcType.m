//
//  FLObjcType.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcType.h"
#import "FLObjcName.h"

@interface FLObjcType ()
@property (readwrite, strong, nonatomic) FLObjcName* typeName;
@property (readwrite, strong, nonatomic) NSString* importFileName;
@end

@implementation FLObjcType

@synthesize typeName = _typeName;
@synthesize importFileName = _importFileName;

- (id) initWithTypeName:(FLObjcName*) typeName 
         importFileName:(NSString*) importFileName {

    self = [super init];
    if(self) {
        self.typeName = typeName;
        self.importFileName = importFileName;
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
	[_typeName release];
    [_importFileName release];
    [super dealloc];
}
#endif

- (id) init {	
	self = [super init];
	if(self) {
		
	}
	return self;
}

- (BOOL) isObject {
    return NO;
}

- (NSUInteger) hash {
    return [self.generatedName hash];
}

- (BOOL) isEqual:(id)object {
    return FLStringsAreEqual([object generatedName], [self generatedName]);
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@: %@", [super description], self.generatedName];
}

- (NSString*) generatedReference {
    return self.typeName.generatedReference;
}

- (NSString*) generatedName {
    return self.typeName.generatedName;
}

- (NSString*) generatedObjectClassName {
    return self.typeName.generatedName;
}

- (id) copyWithZone:(NSZone*) zone {
    return [[[self class] alloc] initWithTypeName:self.typeName importFileName:self.importFileName];
}

@end

@implementation FLObjcObjectType

+ (id) objcObjectType:(FLObjcName*) typeName 
       importFileName:(NSString*) importFileName {

    return FLAutorelease([[[self class] alloc] initWithTypeName:typeName importFileName:importFileName]);
}

- (NSString*) generatedReference {
    return [NSString stringWithFormat:@"%@*", [super generatedReference]];
}

- (BOOL) isObject {
    return YES;
}

@end

@implementation FLObjcValueType

+ (id) objcValueType:(FLObjcName*) typeName 
       importFileName:(NSString*) importFileName {

    return FLAutorelease([[[self class] alloc] initWithTypeName:typeName importFileName:importFileName]);
}

- (BOOL) isObject {
    return NO;
}

@end

@implementation FLObjcEnumType
+ (id) objcEnumType:(FLObjcName*) typeName 
       importFileName:(NSString*) importFileName {
    return FLAutorelease([[[self class] alloc] initWithTypeName:typeName importFileName:importFileName]);
}

@end

@implementation FLObjcProtocolType
+ (id) objcProtocolType:(FLObjcName*) typeName 
       importFileName:(NSString*) importFileName {
    return FLAutorelease([[[self class] alloc] initWithTypeName:typeName importFileName:importFileName]);
}

@end

@implementation FLObjcAbstractObjectType 
- (id) init {	
	return [self initWithTypeName:[FLObjcImportedName objcImportedName:@"id"] importFileName:nil];
}
+ (id) objcAbstractObjectType {
    return FLAutorelease([[[self class] alloc] init]);
}
- (BOOL) isObject {
    return YES;
}
@end


@implementation FLObjcVoidType 
- (id) init {	
	return [self initWithTypeName:[FLObjcImportedName objcImportedName:@"void"] importFileName:nil];
}
+ (id) objcVoidType {
    return FLAutorelease([[[self class] alloc] init]);
}
- (BOOL) isObject {
    return NO;
}
@end


@implementation FLObjcContainerType
@synthesize containerSubTypes = _containerSubTypes;

- (id) init {	
	self = [super init];
	if(self) {
		_containerSubTypes = [[NSMutableArray alloc] init];
	}
	return self;
}

+ (id) objcContainerType {
    return FLAutorelease([[[self class] alloc] init]);
}


#if FL_MRC
- (void) dealloc {
	[_containerSubTypes release];
	[super dealloc];
}
#endif

- (void) addContainerSubType:(FLObjcContainerSubType*) subType {
    [_containerSubTypes addObject:subType];
}

@end


@implementation FLObjcContainerSubType
@synthesize subTypeName = _subTypeName;
@synthesize objcType = _objcType;

#if FL_MRC
- (void) dealloc {
	[_subTypeName release];
    [_objcType release];
    [super dealloc];
}
#endif

- (id) initWithName:(NSString*) name objcType:(FLObjcType*) objcType {	
	self = [super init];
	if(self) {
		self.subTypeName = name;
        self.objcType = objcType;
	}
	return self;
}

+ (id) objcContainerSubType:(NSString*) name objcType:(FLObjcType*) objcType {
    return FLAutorelease([[[self class] alloc] initWithName:name objcType:objcType]);
}

@end

@implementation FLObjcNumberObjectType 

- (id) init {	
	return [super initWithTypeName:[FLObjcImportedName objcImportedName:@"NSNumber"] importFileName:nil];
}

+ (id) objcNumberObjectType {
    return FLAutorelease([[[self class] alloc] init]);
}

@end

@implementation FLObjcNumberValueType 

- (NSString*) generatedObjectClassName {
    return @"NSNumber";
}

@end

@implementation FLObjcBoolType 

- (id) init {	
	return [super initWithTypeName:[FLObjcImportedName objcImportedName:@"BOOL"]  importFileName:nil];
}

+ (id) objcBoolType {
    return FLAutorelease([[[self class] alloc] init]);
}

- (BOOL) isObject {
    return NO;
}

//+ (id) objcNumberValueType:(NSString*) numberType {
//    return FLAutorelease([[[self class] alloc] init]);
//}
@end


@implementation FLObjcGeometryType 
@end

@implementation FLObjcArrayType

//- (id) init {	
//	return [super initWithTypeName:[FLObjcImportedName objcImportedName:@"NSMutableArray"] importedFileName:nil];
//}

- (NSString*) generatedName {
    return @"NSMutableArray";
}


+ (id) objcArrayType:(FLObjcName*) typeName 
       importFileName:(NSString*) importFileName {
       return [super objcObjectType:typeName importFileName:importFileName];
}


@end