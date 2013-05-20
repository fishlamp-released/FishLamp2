//
//	GtCodeGenerator.h
//	PackMule
//
//	Created by Mike Fullerton on 8/8/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtStringBuilder.h"
#import "GtStringUtilities.h"
#import "GtCodeGeneratorAll.h"

#define GtCodeGeneratorErrorDomain @"GtCodeGeneratorErrorDomain"

#define GtCodeGeneratorErrorCodeItemExists 1000
#define GtCodeGeneratorErrorCodeDuplicateItem 1001
#define GtCodeGeneratorErrorCodeUnexpectedlyEmptyString 1002
#define GtCodeGeneratorErrorCodeUnknownTypeErrorCode 1003


@interface GtCodeGenerator : NSObject {
@private
	NSMutableArray* m_files;
	NSMutableArray* m_addedFiles;
	NSMutableArray* m_changedFiles;
	NSMutableArray* m_unchangedFiles;
	NSMutableArray* m_removedFiles;

	NSMutableDictionary* m_oldContents;
	NSMutableArray* m_comments;
	GtStringBuilder* m_diffs;
	GtCodeGeneratorProject* m_schema;
	NSString* m_parentFolder;
	
	NSString* m_archiveFolder;
}

@property (readonly, assign) NSString* codeFileFolder;
@property (readonly, assign) NSString* parentFolder;
@property (readonly, assign) NSMutableArray* files;
@property (readonly, assign) GtCodeGeneratorProject* schema;
@property (readonly, assign) NSMutableArray* addedFiles;
@property (readonly, assign) NSMutableArray* changedFiles;
@property (readonly, assign) NSMutableArray* unchangedFiles;
@property (readonly, assign) NSMutableArray* removedFiles;
@property (readonly, assign) NSMutableArray* comments;

@property (readwrite, assign) GtStringBuilder* diffs;

- (void) generateCode:(NSString*) fromUri
	schema:(GtCodeGeneratorProject*) schema 
	objectsToAddOrMerge:(GtCodeGeneratorProject*) postObjects;

+ (GtCodeGeneratorObject*) getObjectByType:(GtCodeGeneratorProject*) schema type:(NSString*) type;

- (GtCodeGeneratorObject*) getObjectInSchema:(NSString*) objectName;

- (GtCodeGeneratorEnumType*) getEnum:(NSString*) typeName;

- (void) getResultsString:(GtStringBuilder*) builder;

- (NSString*) archiveFolderPath;
- (NSString*) objectsFolderPath;

- (NSString*) getTypeName:(NSString*) typeName;

- (void) configureForCodeGeneration;
- (void) generateCode;

- (GtCodeGeneratorTypeDefinition*) typeForName:(NSString*) typeName;

- (NSString*) typeStringForGeneratedCode:(NSString*) typeName;

- (void) addDependency:(GtCodeGeneratorTypeDefinition*) dependency;
- (void) addTypeDefinition:(GtCodeGeneratorTypeDefinition*) definition;

@end

#define FailIfStringIsEmpty(__s__, __msg__, ...) if(GtStringIsEmpty(__s__)) \
	GtFail(GtCodeGeneratorErrorDomain, GtCodeGeneratorErrorCodeUnexpectedlyEmptyString, @"Unexpectedly empty string: %s", #__s__)

#define CheckString(__s__) _CheckString(__s__, #__s__)

extern
NSString* _CheckString(NSString* str, const char* cstr);
