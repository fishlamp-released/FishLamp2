//
//  GtObjC.h
//  FishLampiOS-Lib
//
//  Created by Mike Fullerton on 2/18/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

// WARNING: don't import anything here. This file is imported by FishLamp.  This is imported by everything.

#if DEBUG
    #define GT_SHIP_ONLY_INLINE 
#else
    #define GT_SHIP_ONLY_INLINE NS_INLINE
#endif

// NEEDED for NON-ARC BUILDS

#if __has_feature(objc_arc)
#define OBJC_ARC 1
#undef GT_DEALLOC
#else
#define GT_DEALLOC 1
#endif

#if __has_feature(objc_arc)
    #define GtAutorelease(__v) 
    #define GtReturnAutoreleased(__v)   __v
    #define GtReturnRetained(__v)       __v
    #define GtRetain(__v) 
    #define GtRelease(__v) 
    #define GtSuperDealloc()
    #define GtReleaseBlockWithNil(b)    b = nil
    #define GtReleaseWithNil(b)         b = nil
    #define GtAssignObject(a,b)         a = b
    #define GtCopyObject(a,b)           a = [b copy]
    #define GtCopyBlock(a,b)            a = [b copy]
    
    #undef GT_DEALLOC

#else
    NS_INLINE
    BOOL _GtAssignObject(id* a, id b)
    {
        if(a && (*a != b)) 
        { 
            [*a release]; 
            *a = [b retain]; 
            return YES;
        }
        return NO;
    }
    NS_INLINE
    BOOL _GtCopyObject(id* a, id b)
    {
        if(a && (*a != b)) 
        { 
            [*a release]; 
            *a = [b copy]; 
            return YES;
        }
        return NO;
    }
    NS_INLINE
    BOOL _GtReleaseWithNil(id* p)
    {
        if(p && *p) {
            [*p release];
            *p = nil;
            return YES;
        }
        return NO;
    }
    
    #define GtRetain(__v)               [__v retain]
    #define GtReturnRetained(__v)       [__v retain]
    #define GtRelease(__v)              [__v release]
    #define GtReturnAutoreleased(__v)   [__v autorelease]
    #define GtAutorelease(__v)          [__v autorelease]
    #define GtSuperDealloc()            [super dealloc]
    #define GtReleaseWithNil(p)         _GtReleaseWithNil((id*) &p)
    #define GtReleaseBlockWithNil(b)    GtReleaseWithNil(b)
    #define GtAssignObject(a,b)         _GtAssignObject((id*) &(a), (id) b)
    #define GtCopyObject(a,b)           _GtCopyObject((id*) &a, (id) b)
    #define GtCopyBlock(a,b)            _GtCopyObject((id*) &a, (id) b)
    
                                        
#endif

#define Gt_atomic 

//// deprecated (Gt prefix used to be Gt)
//extern void GtAssignObject(id,id) __attribute__((deprecated));
//extern void GtRetain(id) __attribute__((deprecated));
//extern void GtReturnRetained(id) __attribute__((deprecated));
//extern void GtRelease(id) __attribute__((deprecated));
//extern void GtReturnAutoreleased(id) __attribute__((deprecated));
//extern void GtAutorelease(id) __attribute__((deprecated));
//extern void GtSuperDealloc() __attribute__((deprecated));
//extern void GtReleaseWithNil(id) __attribute__((deprecated));
//extern void GtReleaseBlockWithNil(id) __attribute__((deprecated));
//extern void GtCopyObject(id, id) __attribute__((deprecated));
//extern void GtCopyBlock(id, id) __attribute__((deprecated));



// note to self
//return \[([A-Za-z_0-9:.\ \(\)\[\]]*)\ autorelease]

// regext to remove GtAlloc:
// find: GtAlloc\(([A-Za-z_0-9\[\]]*)\)
// replace: [\1 alloc]

// regext to add GtRelease:
// \[([A-Za-z_0-9\[\]]*)\ release]
// GtRelease(\1)


// GtReturnAutoreleased\(([a-zA-Z *@*&^0-9\[\]\(\):]*)\)
// \1


