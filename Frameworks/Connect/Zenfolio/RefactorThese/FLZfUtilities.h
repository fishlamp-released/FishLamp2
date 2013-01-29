//
//  FLZfUtilities.h
//  ZenfolioDownloader
//
//  Created by patrick machielse on 30-8-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//	append (x) to make path unique
NSString *FLZfUniquePath(NSString *path);

//	convert time in seconds to string
NSString *FLZfTimeString(int secs);

//	read a long long value from a string
//long long FLZfParseLongLong(NSString *longString);

//	gather words from the passed string
NSArray *FLZfParseWords(NSString *string);


