//
//	GtCodeGeneratorCodeSnippetMore.m
//	PackMule
//
//	Created by Mike Fullerton on 4/18/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import "GtCodeGeneratorCodeSnippetMore.h"


@implementation GtCodeGeneratorCodeSnippet (More)

//- (NSString*) performSnippetSubstitutions:(NSString*) code
//{
//	  for(GtCodeGeneratorVariable* sub in self.substitutions)
//	  {
//		  code = [code stringByReplacingOccurrencesOfString:sub.name withString:sub.type];
//	  }
//	  
//	  return code;
//}
//	  
//- (void) generateFromFile:(GtObjectiveCCodeGenerator*) generator
//	  builder: (GtStringBuilder*) builder
//	  parent:(NSString*) parent
//{
//	  GtThrowIfStringEmpty(self.name);
//
//	  NSString* name = [NSString stringWithFormat:@"%@.%@.m", parent, self.name];
//
//	  NSString* path = [generator.codeFileFolder stringByAppendingPathComponent:name];
//	  NSString* contents = nil;
//	  NSError* err = nil;
//		  
//	  if([[NSFileManager defaultManager] fileExistsAtPath:path])
//	  {
//		  contents = [NSString stringWithContentsOfFile:path encoding:NSASCIIStringEncoding error:&err];
//		  contents = [self performSnippetSubstitutions:contents];
//	  }
//	  else
//	  {
//		  contents = @"// created by PackMule.\n"; // [NSString stringWithFormat:@"%@\n{\n // created by PackMule.\n}", [self getMethodDeclaration:method]];
//		  [contents writeToFile:path atomically:NO encoding:NSASCIIStringEncoding error:&err];
//	  }
//	  
//	  [generator.addedFiles addObject:path];
//
//	  GtThrowOnError(err);
//	  [builder appendLine:contents];
//}

- (void) generate:(GtObjectiveCCodeGenerator*) generator
	object: (GtCodeGeneratorObject*) obj
	builder: (GtStringBuilder*) builder
{
	if(GtStringIsNotEmpty(self.scopedBy))
	{
		[builder appendLine:self.scopedBy];
			
		[builder appendLine:@"{"];
		[builder tabIn];
	}

//	  if(self.useFile)
//	  {
//		  [self generateFromFile:generator builder:builder parent:obj.type];
//	  }

	if(GtStringIsNotEmpty(self.lines))
	{
		[builder appendLines:self.lines trimWhitespace:NO];
	}

//	  if(GtStringIsNotEmpty(self.lines))
//	  {
//		  [builder appendLines:[self performSnippetSubstitutions:self.lines]];
//	  }
	
	if(GtStringIsNotEmpty(self.scopedBy))
	{
		[builder tabOut];
		[builder appendLine:@"}"];
	}
}


@end
