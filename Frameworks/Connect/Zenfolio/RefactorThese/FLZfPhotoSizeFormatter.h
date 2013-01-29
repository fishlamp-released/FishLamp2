//
//  FLZfPhotoSizeFormatter.h
//  ZenfolioDownloader
//
//  Created by patrickm on 19-11-07.
//  Copyright 2007 GreenTongue Software, LLC.. All rights reserved.
//

#import <Cocoa/Cocoa.h>


/*!
    @header		FLZfPhotoSizeFormatter
    @abstract   Validates and formats the value entered for the photo resize-value. The underlying value is an NSNumber.
*/


@interface FLZfPhotoSizeFormatter : NSFormatter {
}

+ (id)formatter;

@end
