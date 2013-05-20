//
//	GtCodeGeneratorProjectManager.h
//	PackMule
//
//	Created by Mike Fullerton on 8/15/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtStringBuilder.h"
#import "GtCodeGeneratorAll.h"

@protocol GtCodeTranslator <NSObject>

- (BOOL) willTranslate:(NSString*) fileUrl;
- (void) buildCodeGeneratorSchema:(NSString*) fromFilePath project:(GtCodeGeneratorProject*) project codeSchema:(GtCodeGeneratorProject*) codeSchema;
@end

@interface GtCodeGeneratorProjectManager : NSObject<GtCodeTranslator> {
	GtStringBuilder* m_output;
	NSMutableArray* m_codeTranslators;
	NSMutableArray* m_generators;
}
@property (readwrite, assign, nonatomic) GtStringBuilder* output;

- (void) addCodeTranslator:(id<GtCodeTranslator>) translator;
- (void) generateCodeWithProject:(GtCodeGeneratorProject*) project	projectFilePath:(NSString*) filePath;

- (BOOL) saveProject:(GtCodeGeneratorProject*) project filePath: (NSString*) filePath;

- (GtCodeGeneratorProject*) createEmptyProject;


// TEMP: DON"T CALL
- (void) _generateCodeWithProject:(GtCodeGeneratorProject*) project projectFilePath:(NSString*) filePath;



@end
