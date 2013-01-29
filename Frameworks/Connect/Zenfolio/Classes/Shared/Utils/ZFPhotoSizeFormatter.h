//
//  ZFPhotoSizeFormatter.h
//  ZenfolioDownloader
//
//  Created by patrickm on 19-11-07.
//  Copyright 2007 Zenfolio, Inc.. All rights reserved.
//

#import <Cocoa/Cocoa.h>


/*!
    @header		ZFPhotoSizeFormatter
    @abstract   Validates and formats the value entered for the photo resize-value. The underlying value is an NSNumber.
*/


@interface ZFPhotoSizeFormatter : NSFormatter {
}

+ (id)formatter;

@end
