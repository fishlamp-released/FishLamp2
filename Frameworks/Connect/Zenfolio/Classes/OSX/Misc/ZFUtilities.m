//
//  utility.m
//  ZenfolioDownloader
//
//  Created by patrick machielse on 30-8-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

#import "ZFUtilities.h"



//	append (x) to make path unique
NSString *ZFUniquePath(NSString *path)
{
	NSString *uniquePath = path;
	
	int number = 2;
	while ( [[NSFileManager defaultManager] fileExistsAtPath:uniquePath] ) {
		NSString *ext = [path pathExtension];
		uniquePath = [path stringByDeletingPathExtension]; 
		uniquePath = [uniquePath stringByAppendingFormat:@" (%d)", number++];
		if ( ![ext isEqualToString:@""] ) {
			uniquePath = [uniquePath stringByAppendingPathExtension:ext];
		}
	}
	return uniquePath;
}

//	convert time in seconds to string
NSString *ZFTimeString(int secs)
{
	NSMutableString *time = [NSMutableString string];
	if ( secs > 3600 ) {
		[time appendFormat:@"%d hours ", secs / 3600];
		secs = secs % 3600;
	}
	if ( secs > 60 ) {
		[time appendFormat:@"%d minutes ", secs / 60];
		secs = secs % 60;
	}
	[time appendFormat:@"%d seconds", secs];
	return time;
}


//	gather words from the passed string
NSArray *ZFParseWords(NSString *string)
{
	NSMutableArray *words = [NSMutableArray array];
	if ( !string ) {
		return words;
	}
	
	if ( [string rangeOfString:@"\""].length == 0 ) {
		//	there are no quoted parts: just parse the string
		NSScanner  *scanner = [NSScanner scannerWithString:string];
		NSCharacterSet *sep = [NSCharacterSet characterSetWithCharactersInString:@" ,;"];
		[scanner setCharactersToBeSkipped:sep];
		
		NSString *word;
		while ( [scanner scanUpToCharactersFromSet:sep intoString:&word] ) {
			[words addObject:word];
		}
	} else {
		//	there are quoted parts: proces unquoted parts recursively
		NSArray *quotedParts = [string componentsSeparatedByString:@"\""];
		int i;
		for ( i = 0; i <  [quotedParts count]; i++ ) {
			if ( i % 2 == 0 ) {
				[words addObjectsFromArray:ZFParseWords([quotedParts objectAtIndex:i])];
			} else {
				[words addObject:[quotedParts objectAtIndex:i]]; /* "quoted words" */
			}
		}
	}
	return words;
}
