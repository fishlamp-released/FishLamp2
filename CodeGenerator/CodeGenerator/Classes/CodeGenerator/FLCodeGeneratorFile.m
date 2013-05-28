//
//  FLCodeGeneratorFile.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 1/6/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeGeneratorFile.h"

@interface NSString (MoveToWhittle)


+ (BOOL) linesAreEqual:(NSArray*) lhs 
	rhs:(NSArray*) rhs 
	startString:(NSString*) startString
	lhsName:(NSString*) lhsName
	rhsName:(NSString*) rhsName
	output:(FLCodeBuilder*) output;
	
- (BOOL) linesAreEqualTo:(NSString*) otherString 
	startString:(NSString*) startString
	lhsName:(NSString*) lhsName
	rhsName:(NSString*) rhsName
	output:(FLCodeBuilder*) output;

@end

#import "NSString+Lists.h"
#import "FLCodeBuilder.h"


@implementation NSString (MoveToWhittle)


+ (BOOL) linesAreEqual:(NSArray*) lhs 
	rhs:(NSArray*) rhs 
	startString:(NSString*) startString
	lhsName:(NSString*) lhsName
	rhsName:(NSString*) rhsName
	output:(FLCodeBuilder*) output
{
	if(!output && lhs.count != rhs.count) {
		return NO;
	}
	
    BOOL started = startString == nil;
	BOOL outputHeader = NO;
    BOOL areSame = YES;

	NSUInteger numLines = MIN(lhs.count, rhs.count);
    
	for(NSUInteger i = 0; i < numLines; i++) {
		NSString* lhsStr = [lhs objectAtIndex:i];
		NSString* rhsStr = [rhs objectAtIndex:i];
		
		if(!started) {
			if([lhsStr rangeOfString:startString].length > 0) {
				started = YES;
			}
		} else if(![lhsStr isEqualToString:rhsStr]) {
			if(output) {
				areSame = NO;
				if(!outputHeader) {
					outputHeader = YES;
					[output appendLine:@"Comparison between:"];
					[output indent: ^{
                        [output appendLine:lhsName];
                        [output appendLine:rhsName];
                    } ];
				}

                [output indent:^{
                    [output appendLine:@"Lines are different:"];
                    [output indent:^{
                        [output appendLineWithFormat:@"'%@'", lhsStr];
                        [output appendLineWithFormat:@"'%@'", rhsStr];
                    }];
                }];
            }
			else {
				return NO;
			}
		}
	}
	
	if(lhs.count != rhs.count) {
		if(output) {
            if(!outputHeader) {
            //	outputHeader = YES;
                
                [output appendLine:@"Comparison between:"];
                
                [output indent: ^ {;
                    [output appendLine:lhsName];
                    [output appendLine:rhsName];
                }];
            }
            
            if(lhs.count > rhs.count) {
                [output appendLineWithFormat: @"lines not in %@:", rhsName];
                
                [output indent:^{
                    for(NSUInteger i = rhs.count; i < lhs.count; i++){
                        [output appendLineWithFormat:@"%@", [lhs objectAtIndex:i]];
                    }
                }];
                
            } else if(rhs.count > lhs.count) {
                [output appendLineWithFormat: @"lines not in %@:", lhsName];

                [output indent:^{
                    for(NSUInteger i = lhs.count; i < rhs.count; i++) {
                        [output appendLineWithFormat:@"%@", [rhs objectAtIndex:i]];
                    }
                }];
            }
		}
		areSame = NO;
	}
	
	return areSame;
}

- (BOOL) linesAreEqualTo:(NSString*) otherString 
	startString:(NSString*) startString
	lhsName:(NSString*) lhsName
	rhsName:(NSString*) rhsName
	output:(FLCodeBuilder*) output {
	return [NSString linesAreEqual:[self lines] rhs:[otherString lines] startString:startString lhsName:lhsName rhsName:rhsName output:output];
} 


@end


@implementation FLCodeGeneratorFile
@synthesize fileName = _fileName;

- (id) initWithFileName:(NSString*) name  {
    self = [super init];
    if(self) {
        self.fileName = name;
    }
    return self;
}

+ (id) codeGeneratorFile {
    return FLAutorelease([[[self class] alloc] initWithFileName:nil]);
}

+ (id) codeGeneratorFile:(NSString*) name {
    return FLAutorelease([[[self class] alloc] initWithFileName:name]);
}

- (BOOL) canUpdateExistingFile {
    return NO;
}

- (BOOL) isTheSameAsFileOnDisk:(NSString*) oldFile fileContents:(NSString*) fileContents {
	
    NSError* err = nil;
	NSString* existingFileContents = [[NSString alloc] initWithContentsOfFile:oldFile 
                                                                     encoding:NSUTF8StringEncoding error:&err];
    @try {
        if(err){
            FLThrowIfError(err);
        }
       
        return [existingFileContents linesAreEqualTo:fileContents 
                                         startString:[fileContents rangeOfString:@"DO NOT MODIFY"].length > 0 ? @"DO NOT MODIFY" : nil
                                             lhsName:[NSString stringWithFormat:@"%@ (old)", oldFile] 
                                             rhsName:[NSString stringWithFormat:@"%@ (new)", self.fileName]
                                              output:nil];
    }
    @finally {
        FLRelease(existingFileContents);
    }
}

- (void) writeCodeToCodeBuilder:(FLCodeBuilder*) codeBuilder {
}

- (FLCodeGeneratorFileWriteResult) writeFileToPath:(NSString*) path 
                                  withCodeBuilder:(FLCodeBuilder*) codeBuilder {

    [self writeCodeToCodeBuilder:codeBuilder];
    
    FLPrettyString* string = [FLPrettyString prettyString:[FLWhitespace tabbedWithSpacesWhitespace]];
    [string appendBuildableString:codeBuilder];
    NSString* fileContents = [string string];
    FLAssertStringIsNotEmpty(fileContents);

    BOOL exists = NO;

    if( [[NSFileManager defaultManager] fileExistsAtPath:path] ) {
        if(![self canUpdateExistingFile] || 
           [self isTheSameAsFileOnDisk:path fileContents:fileContents]) {
            return FLCodeGeneratorFileWriteResultUnchanged;
        }
        exists = YES;
    }
    
    NSError* err = nil;
    [fileContents writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if(err) {
        FLThrowIfError(FLAutorelease(err));
    }
        
    return exists ? 
        FLCodeGeneratorFileWriteResultUpdated :
        FLCodeGeneratorFileWriteResultNew;
}




@end
