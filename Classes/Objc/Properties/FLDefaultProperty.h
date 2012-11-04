//
//  FLDefaultProperty.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

// Default Property (this needs to be modernized with dispatch_once
	
#define _FLDefaultName(NAME) s_default##NAME	

#define FLDefaultProperty(CLASS, NAME) \
	+ (CLASS*) default##NAME; \
	+ (void) setDefault##NAME:(CLASS*) inObj; \
	+ (void) releaseDefault##NAME; \
	+ (BOOL) default##NAMEIsNil; \
	+ (BOOL) createDefault##NAMEIfNil	
	
#define FLSynthesizeDefault(CLASS, NAME) \
	static CLASS* _FLDefaultName(NAME) = nil; \
	+ (CLASS*) default##NAME { \
		if(_FLDefaultName(NAME) == nil) { \
			@synchronized(self) { \
				if (_FLDefaultName(NAME) == nil) { \
					_FLDefaultName(NAME) = [[CLASS alloc] init]; \
				} \
			} \
		} \
		return _FLDefaultName(NAME); \
	} \
	+ (void) setDefault##NAME:(CLASS*) inObj { \
		if(_FLDefaultName(NAME) != inObj) { \
			@synchronized(self) { \
				if(_FLDefaultName(NAME) != inObj) { \
					release_(_FLDefaultName(NAME)); \
					_FLDefaultName(NAME) = inObj; \
				} \
			} \
		} \
	} \
	+ (void) releaseDefault##NAME { \
		[CLASS setDefault##NAME:nil]; \
		_FLDefaultName(NAME) = nil; \
	} \
	+ (BOOL) default##NAMEIsNil { \
		return _FLDefaultName(NAME) == nil; \
	} \
	+ (BOOL) createDefault##NAMEIfNil { \
		BOOL out = (_FLDefaultName(NAME) == nil); \
		[CLASS default##NAME]; \
		return out; \
	} 
