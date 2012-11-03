//
//  FLUnitTestObserver.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

//#import "FLUnitTestObserver.h"
//
//@implementation FLUnitTestObserver
//
//+ (id<FLUnitTestObserver>) unitTestObserver {
//    return autorelease_([[FLUnitTestObserver alloc] init]);
//}
//
//@synthesize discovered = _discovered;
//@synthesize willFilter = _willFilter;
//@synthesize willAllow = _willAllow;
//@synthesize observeStart = _observeStart;
//@synthesize observeFinish = _observeFinish;
//@synthesize observeResult = _observeResult;
//@synthesize observeAllResults = _observeAllResults;
//
//#if FL_MRC
//- (void) dealloc {
//    mrc_release_(_willFilter);
//    mrc_release_(_discovered);
//    mrc_release_(_willAllow);
//    mrc_release_(_observeStart);
//    mrc_release_(_observeFinish);
//    mrc_release_(_observeResult);
//    mrc_release_(_observeAllResults);
//    super_dealloc_();
//}
//#endif
//
//@end
