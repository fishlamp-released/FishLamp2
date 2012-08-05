//
//  FLObjC.h
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/18/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

#if DEBUG
    #define FL_SHIP_ONLY_INLINE 
#else
    #define FL_SHIP_ONLY_INLINE NS_INLINE
#endif

// NEEDED for NON-ARC BUILDS

#if __has_feature(objc_arc)
#define OBJC_ARC 1
#undef FL_DEALLOC
#else
#define FL_DEALLOC 1
#endif

#if __has_feature(objc_arc)
    #define FLAutorelease(__v) 
    #define FLReturnAutoreleased(__v)   __v
    #define FLReturnRetained(__v)       __v
    #define FLRetain(__v) 
    #define FLRelease(__v) 
    #define FLSuperDealloc()
    #define FLReleaseBlockWithNil(b)    b = nil
    #define FLReleaseWithNil(b)         b = nil
    #define FLAssignObject(a,b)         a = b
    #define FLCopyObject(a,b)           a = [b copy]
    #define FLCopyBlock(a,b)            a = [b copy]
    #undef FL_DEALLOC

    #define __fl_bridge __bridge
    #define __fl_bridge_transfer __bridge_transfer
#else
    NS_INLINE
    void _FLAssignObject(id* a, id b)
    {
        if(a && (*a != b)) 
        { 
            [*a release]; 
            *a = [b retain]; 
        }
    }
    NS_INLINE
    void _FLCopyObject(id* a, id b)
    {
        if(a && (*a != b)) 
        { 
            [*a release]; 
            *a = [b copy]; 
        }
    }
    NS_INLINE
    void _FLReleaseWithNil(id* p)
    {
        if(p && *p) {
            [*p release];
            *p = nil;
        }
    }
    
    #define FLRetain(__v)               [__v retain]
    #define FLReturnRetained(__v)       [__v retain]
    #define FLRelease(__v)              [__v release]
    #define FLReturnAutoreleased(__v)   [__v autorelease]
    #define FLAutorelease(__v)          [__v autorelease]
    #define FLSuperDealloc()            [super dealloc]
    #define FLReleaseWithNil(p)         _FLReleaseWithNil((id*) &p)
    #define FLReleaseBlockWithNil(b)    FLReleaseWithNil(b)
    #define FLAssignObject(a,b)         _FLAssignObject((id*) &a, (id) b)
    #define FLCopyObject(a,b)           _FLCopyObject((id*) &a, (id) b)
    #define FLCopyBlock(a,b)            _FLCopyObject((id*) &a, (id) b)

    #define __fl_bridge
    #define __fl_bridge_transfer 
                 
#endif

#define fl_atomic 

// deprecated (FL prefix used to be Gt)
extern void GtAssignObject(id,id) __attribute__((deprecated));
extern void GtRetain(id) __attribute__((deprecated));
extern void GtReturnRetained(id) __attribute__((deprecated));
extern void GtRelease(id) __attribute__((deprecated));
extern void GtReturnAutoreleased(id) __attribute__((deprecated));
extern void GtAutorelease(id) __attribute__((deprecated));
extern void GtSuperDealloc() __attribute__((deprecated));
extern void GtReleaseWithNil(id) __attribute__((deprecated));
extern void GtReleaseBlockWithNil(id) __attribute__((deprecated));
extern void GtCopyObject(id, id) __attribute__((deprecated));
extern void GtCopyBlock(id, id) __attribute__((deprecated));



// note to self
//return \[([A-Za-z_0-9:.\ \(\)\[\]]*)\ autorelease]

// regext to remove FLAlloc:
// find: FLAlloc\(([A-Za-z_0-9\[\]]*)\)
// replace: [\1 alloc]

// regext to add FLRelease:
// \[([A-Za-z_0-9\[\]]*)\ release]
// FLRelease(\1)


// FLReturnAutoreleased\(([a-zA-Z *@*&^0-9\[\]\(\):]*)\)
// \1


