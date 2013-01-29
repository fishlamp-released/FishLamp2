//
//  ZFUtilities.h
//  ZenfolioDownloader
//
//  Created by patrick machielse on 30-8-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//	append (x) to make path unique
NSString *ZFUniquePath(NSString *path);

//	convert time in seconds to string
NSString *ZFTimeString(int secs);

//	read a long long value from a string
//long long ZFParseLongLong(NSString *longString);

//	gather words from the passed string
NSArray *ZFParseWords(NSString *string);


