//
//	GtProperties.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.


// from: http://cocoawithlove.com/2009/10/memory-and-thread-safe-custom-property.html

#define GtAtomicRetainedSetToFrom(dest, source) \
    objc_setProperty(self, _cmd, (ptrdiff_t)(&dest) - (ptrdiff_t)(self), source, YES, NO)

#define GtAtomicCopiedSetToFrom(dest, source) \
    objc_setProperty(self, _cmd, (ptrdiff_t)(&dest) - (ptrdiff_t)(self), source, YES, YES)

#define GtAtomicAutoreleasedGet(source) \
    objc_getProperty(self, _cmd, (ptrdiff_t)(&source) - (ptrdiff_t)(self), YES)

#define GtAtomicStructToFrom(dest, source) \
    objc_copyStruct(&dest, &source, sizeof(__typeof__(source)), YES, NO)

// synthesize for atomic ints

#define GtSythesizeAtomicInt32Getter(__GETTER__, __TYPE__, __MEMBER_NAME__) \
    - (__TYPE__) __GETTER__ { \
        return (__TYPE__) GtAtomicGet32((int32_t*) &(__MEMBER_NAME__)); \
        } 

#define GtSythesizeAtomicInt32Setter(__SETTER__, __TYPE__, __MEMBER_NAME__) \
    - (void) __SETTER__:(__TYPE__) value { \
        GtAtomicSet32((int32_t*) &(__MEMBER_NAME__), (int32_t)value); \
        }

#define GtSythesizeAtomicInt32Property(__GETTER__, __SETTER__, __TYPE__, __MEMBER_NAME__) \
    GtSythesizeAtomicInt32Getter(__GETTER__, __TYPE__, __MEMBER_NAME__) \
    GtSythesizeAtomicInt32Setter(__SETTER__, __TYPE__, __MEMBER_NAME__)


// synthesize for bit flag properties

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.
#define GtSynthesizeStructGetterProperty(GET_NAME, __type__, STRUCT) \
	- (__type__) GET_NAME { return STRUCT.GET_NAME; } 

#define GtSynthesizeStructProperty(GET_NAME, SET_NAME, __type__, STRUCT) \
	- (__type__) GET_NAME { return STRUCT.GET_NAME; } \
	- (void) SET_NAME:(__type__) inValue { STRUCT.GET_NAME = inValue; }

// singleton property

/// GtSingletonProperty is a macro for defining a singleton object.
/// @param __class The type of the class (for example MyClass). 
#define GtSingletonProperty(__class) + (__class*)instance; \
                                     + (void)createInstance; \
                                     + (void) releaseInstance

/// Synthesizes all the boilerplate for declaring a thread safe fast singleton
#define GtSynthesizeSingleton(__class) \
    static dispatch_once_t s_pred1##__class = 0; \
    static dispatch_once_t s_pred2##__class = 0; \
    static __class* s_instance##__class = nil; \
    + (__class*) instance { \
        dispatch_once(&s_pred1##__class, ^{ s_instance##__class = [[self alloc] init]; s_pred2##__class = 0; }); \
        return s_instance##__class; \
        } \
	+ (void) createInstance { \
        [self instance]; \
    }   \
    + (void) releaseInstance { \
        dispatch_once(&s_pred2##__class, ^{ GtReleaseWithNil(s_instance##__class); s_pred1##__class = 0; }); \
        } 
    
/// this won't work if you use a variable length method of any kind in the block. Enclosing block in params is recommended. 

/// For example: GtReturnStaticObjectFromBlock((^{ return @"foo"; })); 
/// Note: I've spent a fair amount of time trying to work around this issue with the preprocessor. If You have a solution please let me know.
#define GtReturnStaticObjectFromBlock(__CREATE_BLOCK) \
        static dispatch_once_t pred; \
        static id s_static_object = nil; \
        dispatch_once(&pred, ^{ s_static_object = __CREATE_BLOCK(); GtRetain(s_static_object); }); \
        return s_static_object

/// return a object from a selector called only once.
#define GtReturnStaticObjectFromSelector(TARGET, ACTION) \
        static dispatch_once_t pred; \
        static id s_static_object = nil; \
        dispatch_once(&pred, ^{ s_static_object = [TARGET performSelector:ACTION]; GtRetain(s_static_object); }); \
        return s_static_object

#define GtReturnStaticObject(...) return nil

// Default Property (this needs to be modernized with dispatch_once
	
#define _FLDefaultName(NAME) s_default##NAME	

#define GtDefaultProperty(CLASS, NAME) \
	+ (CLASS*) default##NAME; \
	+ (void) setDefault##NAME:(CLASS*) inObj; \
	+ (void) releaseDefault##NAME; \
	+ (BOOL) default##NAMEIsNil; \
	+ (BOOL) createDefault##NAMEIfNil	
	
#define GtSynthesizeDefault(CLASS, NAME) \
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
					[_FLDefaultName(NAME) release]; \
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
