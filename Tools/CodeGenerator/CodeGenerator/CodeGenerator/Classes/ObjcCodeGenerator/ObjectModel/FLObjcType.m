//
//  FLObjcType.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 2/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjcType.h"
#import "FLObjcCodeGeneratorHeaders.h"

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

- (void) addAdditionalStuffToObject:(FLObjcObject*) object forProperty:(FLObjcProperty*) property {

}

@end







