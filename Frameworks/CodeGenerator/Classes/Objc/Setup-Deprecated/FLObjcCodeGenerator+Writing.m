//
//  FLObjcCodeGenerator+Writing.m
//  CodeGenerator
//
//  Created by Mike Fullerton on 3/16/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#if REFACTOR
#import "FLObjcCodeGenerator+Writing.h"
#import "FLObjcCodeGenerator+Types.h"
#import "FLObjcCodeGenerator+Files.h"
#import "FLCodeDataType+Objc.h"
#import "FLObjcUtilities.h"

@interface FLObjcCodeGenerator (WritingMore )
- (void) writeCategory:(FLCodeObjectCategory*) category 
          toHeaderFile:(FLObjcHeaderFile*) headerFile;


- (void) writeCategory:(FLCodeObjectCategory*) category 
          toSourceFile:(FLObjcSourceFile*) sourceFile;


- (void) writeMethod:(FLCodeMethod*) method 
        toHeaderFile:(FLObjcHeaderFile*) headerFile;

- (void) writeMethod:(FLCodeMethod*) method 
        toSourceFile:(FLObjcSourceFile*) sourceFile;

- (void) writeCodeForObject:(FLCodeObject*) object
                ;        

- (void) writeProperty:(FLCodeProperty*) property 
          toHeaderFile:(FLObjcHeaderFile*) header 
           ;

- (void) writeProperty:(FLCodeProperty*) property 
          toSourceFile:(FLObjcSourceFile*) source 
           ;


- (void) writeSnippet:(FLCodeCodeSnippet*) codeSnippet 
         toSourceFile:(FLObjcSourceFile*) sourceFile 
          ;
@end

@implementation FLObjcCodeGenerator (Writing)

- (void) writeAllIncludesFile {
                
	if(self.project.generatorOptions.generateAllIncludesFile) {

        NSString* fileName = [NSString stringWithFormat:kAllIncludesFileName, self.project.schemaName];

        FLObjcHeaderFile* generatedFile = [FLObjcGeneratedHeaderFile codeGeneratorFile:fileName];
//        [generatedFile appendFileFooterToCodeBuilder:generatedFile.codeDocument];
        
        for(FLCodeObject* obj in self.project.objects){
            [generatedFile.codeDocument appendImport:obj.typeName];
        }
        
//        [generatedFile appendFileFooterToCodeBuilder:generatedFile.codeDocument];
        [self addFile:generatedFile];

//        FLCodeGeneratorFile* userFile = [FLObjcUserHeaderFile codeGeneratorFile:self.allIncludesFileName];
//        [self writeFileHeader:userFile addWhittleTag:YES addGeneratedTimeStamp:NO disabled:NO];
//        [userFile.codeBuilder appendLine:kWhittleCloseTag];
//        [userFile.codeBuilder appendBlankLine];
//        [userFile.codebuilder appendLine:headerFile.importStatement];
//        [userFile.codeBuilder appendBlankLine];
//           
//        [self.outputHandler addUserFile:userFile];
    }
}                

- (void) writeCategory:(FLCodeObjectCategory*) category 
          toHeaderFile:(FLObjcHeaderFile*) headerFile
            {

    [headerFile.codeDocument appendBlankLine];
    [headerFile.codeDocument appendLineWithFormat:@"@interface %@ (%@) ", [category objectName], [category categoryName]];

    for(FLCodeProperty* prop in [category properties]) {
        [self writeProperty:prop toHeaderFile:headerFile];
    }
    
    for(FLCodeMethod* method in [category methods]) {
        [self writeMethod:method toHeaderFile:headerFile];
    }

    [headerFile.codeDocument appendLine:@"@end"];

}         

- (void) writeCategory:(FLCodeObjectCategory*) category 
          toSourceFile:(FLObjcSourceFile*) sourceFile 
            {

    [sourceFile.codeDocument appendBlankLine];
    [sourceFile.codeDocument appendLineWithFormat:@"@implementation %@ (%@) ", [category objectName], [category categoryName]];

    for(FLCodeProperty* prop in [category properties]) {
        [self writeProperty:prop toSourceFile:sourceFile];
    }
    
    for(FLCodeMethod* method in [category methods]) {
        [self writeMethod:method toSourceFile:sourceFile];
    }

    [sourceFile.codeDocument appendLine:@"@end"];
}

#pragma mark enums

- (void) generateEnumHeader {
	
    FLCodeGeneratorFile* file = [FLObjcGeneratedHeaderFile codeGeneratorFile:[NSString  stringWithFormat:@"%@Enums", self.project.schemaName]];
	
//    [self writeFileHeader:file addWhittleTag:YES addGeneratedTimeStamp:YES disabled:NO];
    [file.codeDocument appendBlankLine];

    [file.codeDocument appendLine:@"#import \"FishLampCocoa.h\""];
    [file.codeDocument appendLine:@"#import \"FLEnumHandler.h\""];

    // output defines
	for(FLCodeDefine* define in self.project.defines) {
		[file.codeDocument appendLineWithFormat:@"#define %@ %@ %@",	
			define.define, 
			define.isString ? [NSString stringWithFormat:@"@\"%@\"", define.value] : define.value, 
			FLStringIsNotEmpty(define.comment) ? [NSString stringWithFormat:@"// %@", define.comment] : @""];
	}
	
	if(self.project.enumTypes.count) {
		[file.codeDocument appendBlankLine];

        // output string constant defines
		for(FLCodeEnumType* anEnumType in self.project.enumTypes) {
			
//            NSString* typeName = [self prefixedTypeName:anEnumType.typeName];
		
			for(FLCodeEnum* anEnum in anEnumType.enums) {
				NSString* enumName = [self fullyQualifiedEnumName:anEnumType withEnum:anEnum];
				
				if(FLStringIsNotEmpty(anEnum.stringValue)){
					[file.codeDocument appendLineWithFormat:@"#define k%@ @\"%@\"",  enumName, anEnum.stringValue];
				}
				else {
					[file.codeDocument appendLineWithFormat:@"#define k%@ @\"%@\"",  enumName, anEnum.name];
				}
			}
		}

		[file.codeDocument appendBlankLine];
		
        // output typedefs
		for(FLCodeEnumType* anEnumType in self.project.enumTypes)
		{
			NSString* typeName = [self prefixedTypeName:anEnumType.typeName];
		
			if(anEnumType.enums.count > 0)
			{
				[file.codeDocument appendLineWithFormat:@"typedef enum {"];
			
                [file.codeDocument indent: ^{
                    for(FLCodeEnum* anEnum in anEnumType.enums) {
                        if(anEnum.value) {
                            [file.codeDocument appendLineWithFormat:@"%@ = %d,", [self fullyQualifiedEnumName:anEnumType withEnum:anEnum], anEnum.value];
                        }
                        else {
                            [file.codeDocument appendLineWithFormat:@"%@,", [self fullyQualifiedEnumName:anEnumType withEnum:anEnum]];
                        }
                    }
                }];
            
				[file.codeDocument appendLineWithFormat:@"} %@;", typeName];
				[file.codeDocument appendLine:@""];
								
				FLCodeTypeDefinition* type = [self typeDefinitionForTypeName:typeName];
                if(!type) {
                     FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorCodeUnknownTypeErrorCode, @"Can't find definition for type: %@", typeName);
                }
				type.import = file.fileName;
			}
		}
		
        // output lookupt object
		NSString* objName  = [self enumLookupObjectName];
		[file.codeDocument appendBlankLine];
		[file.codeDocument appendLineWithFormat:@"@interface %@ : FLEnumHandler {", objName];
        [file.codeDocument appendLineWithFormat:@"}"];
		[file.codeDocument appendLineWithFormat:@"FLSingletonProperty(%@);", objName];
		
		for(FLCodeEnumType* anEnumType in self.project.enumTypes) {
   			NSString* typeName = [self prefixedTypeName:anEnumType.typeName];
            
            [file.codeDocument appendLine:@""];
            [file.codeDocument appendLineWithFormat:@"- (NSString*) %@:(%@) inEnum;", [self toStringFromEnumFunctionName:typeName], typeName ];
            [file.codeDocument appendLineWithFormat:@"- (%@) %@:(NSString*) inString;", typeName, [self toEnumFromStringFunctionName:typeName]];
        }

		[file.codeDocument appendLine:@"@end"];
    }	 
	
//	[self writeFileFooter:file addWhittleTag:YES disabled:NO];

	[self addFile:file];

//    FLCodeGeneratorFile* mySource = [FLCodeGeneratorFile codeGeneratorFile:[NSString stringWithFormat:@"%@Enums.h", self.project.schemaName]];
////   	[self writeFileHeader:mySource  addWhittleTag:YES addGeneratedTimeStamp:NO disabled:NO];
//    [mySource.codeDocument appendLine:kWhittleCloseTag];
//    [mySource.codeDocument appendBlankLine];
//    [mySource.codeDocument appendLineWithFormat:@"#import \"%@\"", file.fileName]; 
//    [mySource.codeDocument appendBlankLine];
//    [mySource.codeDocument appendLine:@"// Your code here :-)"];
//	[self.outputHandler addUserFile:mySource];
}

- (void) generateInit:(FLCodeGeneratorFile*) file  {
    
    [file.codeDocument appendLine:@"- (id) init {"];
    [file.codeDocument indent:^{
        [file.codeDocument appendLine:@"if((self = [super init])) {"];

        [file.codeDocument indent: ^{
            [file.codeDocument appendLine:@"self.project.enumDictionary = [[NSDictionary alloc] initWithObjectsAndKeys:"];
            [file.codeDocument  indent: ^{

                for(FLCodeEnumType* anEnumType in self.project.enumTypes) {
                    for(FLCodeEnum* anEnum in anEnumType.enums) {
                        NSString* enumName = [self fullyQualifiedEnumName:anEnumType withEnum:anEnum];
                        [file.codeDocument appendLineWithFormat:@"[NSNumber numberWithInt:%@], k%@, ",  enumName, enumName];
                    }
                }
                
                [file.codeDocument appendLine:@" nil];"];
            }];
            
            [file.codeDocument appendLine:@"}"];
        }];
        
        [file.codeDocument appendLine:@"return self;"];
    }];
    
    [file.codeDocument appendLine:@"}"];
}

- (void) generateToStringMethod:(FLCodeGeneratorFile*) file 
{
	for(FLCodeEnumType* anEnumType in self.project.enumTypes) {		
		
        NSString* typeName = [self prefixedTypeName:anEnumType.typeName];
		
		[file.codeDocument appendBlankLine];
		[file.codeDocument appendLineWithFormat:@"- (NSString*) %@:(%@) inEnum {",
            [self toStringFromEnumFunctionName:typeName], typeName];
		
        [file.codeDocument indent:^{
        
            [file.codeDocument appendLine:@"switch(inEnum) {"];
            [file.codeDocument indent: ^{
                for(FLCodeEnum* anEnum in anEnumType.enums) {
                    NSString* enumName = [self fullyQualifiedEnumName:anEnumType withEnum:anEnum];
                    [file.codeDocument appendLineWithFormat:@"case %@: return k%@;", enumName, enumName];
                }
            }];
            
            [file.codeDocument appendLine:@"}"];
            [file.codeDocument appendLine:@"return nil;"];
        }];
        
		[file.codeDocument appendLine:@"}"];
    }
}

- (void) generateFromStringMethod:(FLCodeGeneratorFile*) file 
{
	for(FLCodeEnumType* anEnumType in self.project.enumTypes) {		
		NSString* typeName = [self prefixedTypeName:anEnumType.typeName];

		[file.codeDocument appendBlankLine];
        [file.codeDocument appendLineWithFormat:@"- (%@) %@:(NSString*) inString {", typeName, [self toEnumFromStringFunctionName:typeName]];

        [file.codeDocument indent:^{
            [file.codeDocument appendLineWithFormat:@"return (%@) [self enumFromString:inString];", typeName];
        }];
		
		[file.codeDocument appendLine:@"}"];
	}
}

- (void) generateEnumLookups:(FLCodeGeneratorFile*) file  {
	
    NSString* objName  = [self enumLookupObjectName];
    
	[file.codeDocument appendLineWithFormat:@"@implementation %@", objName];
	[file.codeDocument appendBlankLine];
    [file.codeDocument appendLineWithFormat:@"FLSynthesizeSingleton(%@);", objName];
	[file.codeDocument appendBlankLine];
	
    [self generateInit:file];
	[self generateToStringMethod:file];
    [self generateFromStringMethod:file];
	
//	[file.codeDocument appendLine:@""];
//	[file.codeDocument appendLine:@"- (NSInteger) lookupString:(NSString*) inString {"];
//	[file.codeDocument indent];
//	[file.codeDocument appendLine:@"NSNumber* num = [_strings objectForKey:inString];"];
//
//#if SOFT_FAIL_ENUMS
//	[file.codeDocument appendLine:@"if(!num) { return NSNotFound; } "];
//#else
//    [file.codeDocument appendLine:@"if(!num) { FLThrowErrorCodeWithComment(FLErrorDomain, FLErrorUnknownEnumValue, [NSString stringWithFormat:(NSLocalizedString(@\"Unknown enum value (case sensitive): %@\", nil)), inString]); } "];
//#endif
//	
//    [file.codeDocument appendLine:@"return [num intValue];"];
//	[file.codeDocument undent];
//	[file.codeDocument appendLine:@"}"];


	[file.codeDocument appendLine:@"@end"];
}

- (void) generateEnumSource
{
	if(self.project.enumTypes && self.project.enumTypes.count > 0) {
		NSString* fileName = 
			[NSString  stringWithFormat:@"%@Enums", self.project.schemaName];
	
		FLCodeGeneratorFile* file = [FLObjcGeneratedSourceFile codeGeneratorFile:fileName];
		
//		[self writeFileHeader:file 
//                   addWhittleTag:YES 
//           addGeneratedTimeStamp:YES 
//                        disabled:NO];
                        
//        [file.codeDocument appendBlankLine];
	
		[file.codeDocument appendLineWithFormat:@"#import \"%@Enums.h\"", self.project.schemaName];
				
		[self generateEnumLookups:file];
		
//		[self writeFileFooter:file  addWhittleTag:YES	 disabled:NO];

		[self addFile:file];
        
        
		FLCodeGeneratorFile* mySource = [FLCodeGeneratorFile codeGeneratorFile:[NSString  stringWithFormat:@"%@Enums.m", self.project.schemaName]];
//        [self writeFileHeader:mySource  addWhittleTag:YES addGeneratedTimeStamp:NO disabled:NO];
        [mySource.codeDocument appendLine:kWhittleCloseTag];
        [mySource.codeDocument appendBlankLine];
        [mySource.codeDocument appendLineWithFormat:@"#import \"%@%@Enums%@.h\"", kGeneratedPrefix, self.project.schemaName, kGeneratedSuffix];
        [mySource.codeDocument appendLineWithFormat:@"#import \"%@Enums.h\"", self.project.schemaName]; 
        [mySource.codeDocument appendBlankLine];
        [mySource.codeDocument appendLine:@"// Your code here :-)"];
        [self addFile:file];
    }
}

- (void) writeEnumFiles {

    BOOL hasEnums = self.project.enumTypes.count > 0 || self.project.defines.count > 0;
    if(hasEnums) {
        [self generateEnumHeader];
        [self generateEnumSource];
	}
                
}                

#pragma mark methods 


- (NSString*) methodDefinitionForMethod:(FLCodeMethod*) method 
                             {
	    
    FLConfirmStringIsNotEmptyWithComment(method.name, @"method has no name");

	NSMutableString* string = [NSMutableString string];
	
	[string appendFormat:@"%@ (%@) %@", 
		method.isStatic ? @"+" : @"-", 
		FLStringIsEmpty(method.returnType) ? @"void" : [self typeStringForGeneratedCode:method.returnType],
		method.name];
		
	if(method.parameters && method.parameters.count > 0) {	
		int count = 0;
		for(FLCodeVariable* type in method.parameters) {
			FLConfirmStringIsNotEmptyWithComment(type.name, @"name missing");
			FLConfirmStringIsNotEmptyWithComment(type.typeName, @"type missing");
			if(count++ == 0) {
				[string appendFormat:@":(%@) %@", [self typeStringForGeneratedCode:type.typeName], type.name];
			}
			else {
				[string appendFormat:@" %@:(%@) %@", type.name, [self typeStringForGeneratedCode:type.typeName], type.name];
			}
		}
	}
		
	return string;
}

- (void) writeMethod:(FLCodeMethod*) method 
            toHeaderFile:(FLObjcHeaderFile*) headerFile 
          {

    [headerFile.codeDocument appendBlankLine];
    if(!method.isPrivate && FLStringIsNotEmpty(method.comment)) {
        [headerFile.codeDocument appendLineWithFormat:@"/// %@", method.comment];
	}
    
    [headerFile.codeDocument appendLineWithFormat:@"%@;", [self methodDefinitionForMethod:method]];
    
}

- (void) writeMethod:(FLCodeMethod*) method 
        toSourceFile:(FLObjcSourceFile*) sourceFile 
          {

	if(FLStringIsNotEmpty(method.comment)){
		[sourceFile.codeDocument appendLineWithFormat:@"// %@", method.comment];
	}

	method.code.scopedBy = [self methodDefinitionForMethod:method];
    [self writeSnippet:[method code] toSourceFile:sourceFile];
}

#pragma mark myCode

//- (id) initWithModelObject:(id) modelObject {
//    self = [super initWithModelObject:modelObject];
//    if(self) {
//        self.sourceFileName = [NSString stringWithFormat:@"%@.m", self.object.typeName];
//        self.headerFileName = [NSString stringWithFormat:@"%@.h", self.object.typeName];
//    }
//    
//    return self;
//}
//
//- (void) writeHeader:(id)parent {
//
//   	[self writeFileHeader:self.headerFile 
//            addWhittleTag:YES 
//    addGeneratedTimeStamp:NO 
//                 disabled:self.object.disabled];
//    
//    [self.header appendLine:kWhittleCloseTag];
//    [self.header appendBlankLine];
//
//    [self.header appendLineWithFormat:@"#import \"%@.h\"", [self.object generatedFileName]];
//    [self.header appendBlankLine];
//    [self.header appendLineWithFormat:@"@interface %@ (MyCode)", self.object.typeName];
//    [self.header appendBlankLine];
//    [self.header appendLine:@"// Your methods here. Declare properties and data in your whittle object file."];
//    [self.header appendBlankLine];
//    [self.header appendLine:@"@end"];
//    
//}
//
//- (void) writeSource:(id) parent {
//
//    [self writeFileHeader:self.sourceFile  
//            addWhittleTag:YES 
//    addGeneratedTimeStamp:NO 
//                 disabled:self.object.disabled];
//                 
//    [self.source appendLine:kWhittleCloseTag];
//    [self.source appendBlankLine];
//
//    [self.source appendLineWithFormat:@"#import \"%@.h\"", [self.object generatedFileName]];
//    [self.source appendLineWithFormat:@"#import \"%@\"", self.headerFileName];
//    [self.source appendBlankLine];
//    [self.source appendLineWithFormat:@"@implementation %@ (MyCode)", self.object.typeName];
//    [self.source appendBlankLine];
//    [self.source appendLine:@"// Your code here :-)"];
//    [self.source appendBlankLine];
//    [self.source appendLine:@"@end"];
//}
//

#pragma mark objects

//- (void) generateComment:(FLCodeBuilder*) codeBuilder comment:(NSString*) comment singleLine:(BOOL) singleLine {
//
////	FLConfirmStringIsNotEmpty(comment, CodeGenFail, @"Empty comment", nil);
//
//	if(singleLine) {
//		[codeBuilder appendLineWithFormat:@"/// %@", comment];
//	}
//	else {
//		[codeBuilder appendLine:@"/**"];
//		[codeBuilder appendLine:comment];
//		[codeBuilder appendLine:@"*/"];
//	}
//}

- (void) writeObject:(FLCodeObject*) object 
            toHeaderFile:(FLObjcHeaderFile*) headerFile 
          {

	if(FLStringIsNotEmpty(object.ifDef)) {
		[headerFile.codeDocument appendLineWithFormat:@"#if %@", object.ifDef];
	}

    [headerFile.codeDocument appendLineWithFormat:@"#import \"FishLampCocoa.h\""];

	if(![object.superclass hasPrefix:@"NS"]) {
		[headerFile.codeDocument appendLineWithFormat:@"#import \"%@.h\"", object.superclass];
	}
    
    for(FLCodeTypeDefinition* dependency in object.dependencies) {
        if(FLStringIsNotEmpty(dependency.import) && !dependency.importIsPrivate) {
            if([self dataTypeIsObject:dependency]) {
                [headerFile.codeDocument appendLineWithFormat:@"@class %@;", dependency.typeName];
            }
            else {
                [headerFile.codeDocument appendLineWithFormat:@"#import \"%@\"", dependency.import];
            }
        }
	}

	if(FLStringIsNotEmpty(self.project.comment)) {
        [headerFile.codeDocument appendBlankLine];
		[headerFile.codeDocument appendComment:self.project.comment];
	}
	
    [headerFile.codeDocument appendBlankLine];
	[headerFile.codeDocument appendComment:object.typeName];

	if(FLStringIsNotEmpty(object.comment)) {
		[headerFile.codeDocument appendComment:object.comment];
        [headerFile.codeDocument appendBlankLine];
	}
	
	NSString* protocols = @"";

	if(FLStringIsNotEmpty(object.protocols)) {
		protocols = [NSString stringWithFormat:@"<%@>", object.protocols];
	}

	[headerFile.codeDocument appendLine:[NSString stringWithFormat:@"@interface %@ : %@%@ { ", 
		object.typeName, 
		object.superclass,
		protocols]];
	[headerFile.codeDocument appendLine:@"@private"];
	
    [headerFile.codeDocument indent: ^{
	
        for(FLCodeObjectMemberType* type in object.members) {
            if(!type.isStatic) {
                FLConfirmStringIsNotEmptyWithComment(type.name, @"Expecting name for object member for object: %@", object.typeName);
                FLConfirmStringIsNotEmptyWithComment(type.typeName, @"Expecting type for object member for object: %@", object.typeName);
                [headerFile.codeDocument appendLineWithFormat:@"%@ %@;", [self typeStringForGeneratedCode:type.typeName], type.name];
            }
        }
    }];

	[headerFile.codeDocument appendLine:[NSString stringWithFormat:@"}"]];
	
	if(object.isSingleton) {
        [headerFile.codeDocument appendBlankLine];
		[headerFile.codeDocument appendLineWithFormat:@"FLSingletonProperty(%@); // See FLSingleton.h/m ", FLRemovePointerSplat(object.typeName)];
	}
    
//    for(FLCodeCodeSnippet* snippet in object.sourceSnippets) {
//        [self.snippetWriter writeSnippet:snippet toHeaderFile:headerFile];
//	}
    
	for(FLCodeProperty* prop in object.properties) {
        [self writeProperty:prop toHeaderFile:headerFile];
	}
	
	for(FLCodeMethod* method in object.methods) {
        [self writeMethod:method toHeaderFile:headerFile];
	}

	[headerFile.codeDocument appendBlankLine];
	[headerFile.codeDocument appendLine:[NSString stringWithFormat:@"@end"]];
    
    for(FLCodeObjectCategory* cat in object.categories) {
        [self writeCategory:cat toHeaderFile:headerFile];
	}
}

- (void) writeObject:(FLCodeObject*) object 
            toSourceFile:(FLObjcSourceFile*) sourceFile 
          {

	if(FLStringIsNotEmpty(object.ifDef)) {
		[sourceFile.codeDocument appendLineWithFormat:@"#if %@", object.ifDef];
	}
	
	[sourceFile.codeDocument appendLineWithFormat:@"#import \"%@\"", sourceFile.fileName];

	for(FLCodeTypeDefinition* dependency in object.dependencies) {
        if(FLStringIsNotEmpty(dependency.import)) {
            [sourceFile.codeDocument appendLineWithFormat:@"#import \"%@\"", dependency.import];
        }
	}
	
	[sourceFile.codeDocument appendBlankLine];
	
	[sourceFile.codeDocument appendLineWithFormat:@"@implementation %@", object.typeName];
	
	[sourceFile.codeDocument appendBlankLine];
	
	for(FLCodeObjectMemberType* staticVar in object.members) {
		if([staticVar isKindOfClass:[FLCodeObjectMemberType class]]) {
			if(staticVar.isStatic) {
				if(FLStringIsNotEmpty(staticVar.defaultValue)) {
					NSString* defaultValue = staticVar.defaultValue;
					
					if(FLStringsAreEqual(staticVar.typeName, @"NSString")) {
						defaultValue = [NSString stringWithFormat:@"@\"%@\"", defaultValue];
					}

					[sourceFile.codeDocument appendLineWithFormat:@"static %@ %@ = %@;", 
						[self typeStringForGeneratedCode:staticVar.typeName],
						staticVar.name, 
						defaultValue];
				}
				else {
					[sourceFile.codeDocument appendLineWithFormat:@"static %@ %@;", 
						[self typeStringForGeneratedCode:staticVar.typeName], 
						staticVar.name];
				}
			}
		}
	}
    
    for(FLCodeCodeSnippet* snippet in object.sourceSnippets) {
        [self writeSnippet:snippet toSourceFile:sourceFile];
	}
    
	for(FLCodeProperty* prop in object.properties) {
        [self writeProperty:prop toSourceFile:sourceFile];
	}
	
	for(FLCodeMethod* method in object.methods) {
        [self writeMethod:method toSourceFile:sourceFile];
	}
    
    [sourceFile.codeDocument appendBlankLine];
	[sourceFile.codeDocument appendLine:@"@end"];

    for(FLCodeObjectCategory* cat in object.categories) {
        [self writeCategory:cat toSourceFile:sourceFile];
	}

	if(FLStringIsNotEmpty(object.ifDef)) {
		[sourceFile.codeDocument appendLine:@"#endif"];
	}
}

- (void) writeCodeForObject:(id) object
                 {
 
    FLObjcGeneratedHeaderFile* headerFile = [FLObjcGeneratedHeaderFile codeGeneratorFile:[object typeName]];
    [self writeObject:object toHeaderFile:headerFile];

    FLObjcGeneratedSourceFile* sourceFile = [FLObjcGeneratedHeaderFile codeGeneratorFile:[object typeName]];
    [self writeObject:object toSourceFile:sourceFile];
    
    [self addFile:headerFile];
    [self addFile:sourceFile];
}  


- (void) writeObjectFiles {
    for(FLCodeObject* obj in self.project.objects) {
        [self writeCodeForObject:obj];
    }
}

#pragma mark properties

- (void) writeProperty:(FLCodeProperty*) property 
            toHeaderFile:(FLObjcHeaderFile*) headerFile 
          {

    if(!property.isPrivate) {
		
        FLConfirmStringIsNotEmptyWithComment(property.name, @"prop name is empty");
		FLConfirmStringIsNotEmptyWithComment(property.type, @"type is empty");
        
		NSString* dataType = property.type; // [self dataTypeForCode];
		
		[headerFile.codeDocument appendBlankLine];
		
		if(property.isStatic) {
			// can't use @property for static properties, so declare them manually
			
            if(FLStringIsNotEmpty(property.comment)) {
                [headerFile.codeDocument appendLineWithFormat:@"/// @brief: %@", property.comment];
            }

			[headerFile.codeDocument appendLineWithFormat:@"+ (%@) %@;", [self typeStringForGeneratedCode:dataType], [self getterNameForProperty:property]];
			
			if(!property.isReadOnly && !property.isImmutable){
				[headerFile.codeDocument appendLineWithFormat:@"+ (void) %@:(%@) %@;", [self setterNameForProperty:property], [self typeStringForGeneratedCode:dataType], property.name];
			}
		}
		else {
			NSString* generatedType = [self typeStringForGeneratedCode:dataType];

            BOOL isRetainProperty = [generatedType rangeOfString:@"*"].length > 0 && (property.isWeak == NO);
            
            if(FLStringIsNotEmpty(property.comment)) {
                [headerFile.codeDocument appendLineWithFormat:@"/// @brief: %@", property.comment];
            }

            [headerFile.codeDocument appendLineWithFormat:@"@property (%@, %@, nonatomic) %@ %@;", 
                (property.isReadOnly || property.isImmutable ? @"readonly" : @"readwrite"), 
                (isRetainProperty ? @"strong" : @"assign"),
                generatedType, [self getterNameForProperty:property]];
			
			if(property.arrayTypes.count > 0) {
				for(FLCodeVariable* type in property.arrayTypes) {
					[headerFile.codeDocument appendLineWithFormat:@"/// Type: %@, forKey: %@", 
						[self typeStringForGeneratedCode:FLObjcObjectTypeStringFromString(type.typeName)], type.name];
				}
			}
			
		}
		
	}
}         

- (void) writeProperty:(FLCodeProperty*) property 
            toSourceFile:(FLObjcSourceFile*) sourceFile 
          {

	if(	!property.isStatic &&
		!property.isImmutable &&
		((!property.isReadOnly && !property.setter.hasLines) || !property.getter.hasLines)){
		[sourceFile.codeDocument appendLineWithFormat:@"@synthesize %@ = %@;", property.name, property.memberName];
	}

    [self writeMethod:property.getter toSourceFile:sourceFile];

    if(!property.isReadOnly) {
        [self writeMethod:property.setter toSourceFile:sourceFile];
    }

}

#pragma mark snippets

- (void) writeSnippet:(FLCodeCodeSnippet*) codeSnippet 
             toSourceFile:(FLObjcSourceFile*) sourceFile 
           {
         
	if(FLStringIsNotEmpty([codeSnippet scopedBy])) {
		[sourceFile.codeDocument appendLineWithFormat:@"%@ {", [codeSnippet scopedBy]];
        [sourceFile.codeDocument appendStringContainingMultipleLines:[codeSnippet lines]];
        [sourceFile.codeDocument appendLine:@"}"];
	}
    else {
        [sourceFile.codeDocument appendStringContainingMultipleLines:[codeSnippet lines]];
    }

}         

- (void) writeFilesForProject {
    [self writeObjectFiles];
    [self writeAllIncludesFile];
    [self writeEnumFiles];
}

@end
#endif