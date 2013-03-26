//
//  FLConsoleLogSink.h
//  FLCore
//
//  Created by Mike Fullerton on 11/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLogSink.h"

@interface FLConsoleLogSink : FLLogSink {
}
+ (id) consoleLogSink;
+ (FLLogSink*) consoleLogSink:(FLLogSinkOutputFlags) outputFlags;

@end

