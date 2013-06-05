//
//	FLKeywordListFormatter.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FLDisplayFormatter.h"

@interface FLKeywordListFormatter : NSObject {}
@end

@interface FLStringDisplayFormatter : NSObject {}
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


// TODO: move these somewhere more sensible.
#define FLKilobytes 1024.0
#define FLMegabtyes 1048576.0
#define FLGigabytes 1073741824.0

#define FLBytesToKilobytes(__bytes__) (((CGFloat)(__bytes__)) / FLKilobytes)
#define FLBytesToMegabytes(__bytes__) (((CGFloat)(__bytes__)) / FLMegabtyes)
#define FLBytesToGigabytes(__bytes__) (((CGFloat)(__bytes__)) / FLGigabytes)

extern NSString* FLStringFromByteSize(unsigned long long byteSize);
