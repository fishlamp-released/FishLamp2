//
//	FLKeywordListFormatter.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLDisplayFormatter.h"

@interface FLKeywordListFormatter : NSObject {}
@end

@interface FLStringFormatter : NSObject {}
@end

@interface FLIntFormatter : NSObject {}
@end

@interface FLLongFormatter : NSObject {}
@end

@interface FLDateFormatter : NSObject {
	 NSDateFormatter* _dateFormatter;
}

FLSingletonProperty(FLDateFormatter);
@end

@interface FLBytesDataSizeFormatter : NSObject {}
@end

@interface FLKilobytesDataSizeFormatter : FLBytesDataSizeFormatter {}
@end

@interface FLObjectDescriptionFormatter : NSObject {}
@end

@interface FLSimpleHtmlFormatter : NSObject {}
@end

@interface FLStringListFormatter : NSObject {}
@end