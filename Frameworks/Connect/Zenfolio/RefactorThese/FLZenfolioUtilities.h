//
//  FLZenfolioUtilities.h
//  ZenfolioDownloader
//
//  Created by patrick machielse on 30-8-07.
//  Copyright 2007 GreenTongue Software, LLC.. All rights reserved.
//

#import "FishLampCocoa.h"

//	append (x) to make path unique
NSString *FLZenfolioUniquePath(NSString *path);

//	convert time in seconds to string
NSString *FLZenfolioTimeString(int secs);

//	read a long long value from a string
//long long FLZenfolioParseLongLong(NSString *longString);

//	gather words from the passed string
NSArray *FLZenfolioParseWords(NSString *string);


