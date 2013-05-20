//	This file was generated at 7/3/11 2:39 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorVariable.h
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "GtCodeGeneratorType.h"

// --------------------------------------------------------------------
// GtCodeGeneratorVariable
// --------------------------------------------------------------------
@interface GtCodeGeneratorVariable : GtCodeGeneratorType<NSCopying>{ 
@private
	NSString* m_name;
} 


@property (readwrite, retain, nonatomic) NSString* name;
// name of the type, e.g. bagelCount

+ (NSString*) nameKey;

+ (GtCodeGeneratorVariable*) codeGeneratorVariable; 

@end

@interface GtCodeGeneratorVariable (ValueProperties) 
@end


@interface GtCodeGeneratorVariable (ObjectMembers) 
@end

