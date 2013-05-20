//
//	GtObjectiveCCodeGenerator.h
//	PackMule
//
//	Created by Mike Fullerton on 4/17/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtCodeGenerator.h"

#import "GtDataTypeIDUtilities.h"

@interface GtObjectiveCCodeGenerator : GtCodeGenerator {

}

- (NSString*) getTypeName:(NSString*) typeName;

- (void) generateFileHeader:(GtStringBuilder*) builder 
				   fileName:(NSString*) fileName
				   disabled:(BOOL) disabled
				   generated:(BOOL) generated;

- (void) generateFileFooter:(GtStringBuilder*) builder 
				   fileName:(NSString*) fileName
				   disabled:(BOOL) disabled;
				   
- (NSString*) enumsHeaderFileName;

+ (GtObjectiveCCodeGenerator*) objectiveCCodeGenerator;

@end

