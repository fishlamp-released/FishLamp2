//
//	FishLampCoreRequired.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#define IOS 1

// debugging
#import "GtMobileDebug.h"
#import "GtAsserts.h"

#if DEBUG
#define GtLog NSLog
#define GtLogAssert(condition, log, ...) if(condition) GtLog(log, ##__VA_ARGS__)
#else
#define GtLog 
#define GtLogAssert(condition, log, ...)
#endif


// categories
#import "NSObject+Comparison.h"
#import "NSString+GUID.h"
#import "NSString+Lists.h"

#import "GtBitFlags.h"
#import "GtCallback.h"
#import "GtCallbackObject.h"
#import "GtFunctor.h"
#import "GtKeyValuePair.h"
#import "GtProperties.h"
#import "GtRandom.h"
#import "GtRetainedObject.h"
#import "GtWeakReference.h"
#import "GtGuid.h"
#import "GtStringBuilder.h"

#import "GtTimer.h"
#import "GtErrors.h"

#import "NSObject+Copying.h"

// collections
#import "GtOrderedCollection.h"
#import "GtLinkedList.h"
#import "GtLinkedList.h"

#import "FishLampObjc.h"
#import "GtStringUtils.h"
#import "GtBlocks.h"

#import "GtExceptions.h"
#import "GtVersion.h"
#import "NSArray+GtExtras.h"


//typedef void (^GtIdleBlock)(id target, NSTimeInterval idleForSecondsTimespan);
//typedef void (^GtProgressBlock)(id target, unsigned long long amtWritten, unsigned long long totalAmountWritten, unsigned long long totalAmountExpectedToWrite);

NS_INLINE
BOOL GtIsValidDate(NSDate* date)
{
	return date != nil && date.timeIntervalSinceReferenceDate != 0;
}

#define to_id(obj) ((id) obj)


