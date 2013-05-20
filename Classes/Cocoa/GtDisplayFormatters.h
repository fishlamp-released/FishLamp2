//
//	GtKeywordListFormatter.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtDisplayFormatter.h"

@interface GtKeywordListFormatter : NSObject {}
@end

@interface GtStringFormatter : NSObject {}
@end

@interface GtIntFormatter : NSObject {}
@end

@interface GtLongFormatter : NSObject {}
@end

@interface GtDateFormatter : NSObject {
	 NSDateFormatter* m_dateFormatter;
}

GtSingletonProperty(GtDateFormatter);
@end

@interface GtBytesDataSizeFormatter : NSObject {}
@end

@interface GtKilobytesDataSizeFormatter : GtBytesDataSizeFormatter {}
@end

@interface GtObjectDescriptionFormatter : NSObject {}
@end

@interface GtSimpleHtmlFormatter : NSObject {}
@end

@interface GtStringListFormatter : NSObject {}
@end