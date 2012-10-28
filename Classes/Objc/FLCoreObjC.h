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
#define FL_ARC 1
#undef FL_NO_ARC
#undef FL_NO_ARC
#else
#define FL_NO_ARC 1
#define FL_NO_ARC 1
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
    #undef FL_NO_ARC

    #define FLCopyBlock(__BLOCK__) [__BLOCK__ copy]

    #define __bridge_fl __bridge
    #define __bridge_transfer_fl __bridge_transfer

    NS_INLINE
    void FLManuallyRelease(id* obj) {
        if(obj && *obj) {
            CFRelease((__bridge_retained CFTypeRef) (*obj));
            *obj = nil;
        }
    }

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
//    NS_INLINE
//    void FLManuallyRelease(id* p)
//    {
//        if(p && *p) {
//        // this generates clang warning but this is correct, maybe there's a way to craft the code or a pragma to get rid of the warning
//            [*p release];
//            *p = nil;
//        }
//    }
    
    #define FLRetain(__v)               [__v retain]
    #define FLReturnRetained(__v)       [__v retain]
    #define FLRelease(__v)              [__v release]
    #define FLReturnAutoreleased(__v)   [__v autorelease]
    #define FLAutorelease(__v)          [__v autorelease]
    #define FLSuperDealloc()            [super dealloc]
    #define FLCopyBlock(__BLOCK__)      FLReturnAutoreleased([__BLOCK__ copy])

    NS_INLINE
    void FLManuallyRelease(id* obj) {
        if(obj && *obj) {
            [*obj release];
            *obj = nil;
        }
    }
    typedef void (^__BLOCK)() ;
    NS_INLINE
    void _FLReleaseBlockWithNil(__BLOCK* block) {
        if(block && *block) {
            [*block release];
            *block = nil;
        }
    }

    #define FLReleaseWithNil(__OBJ__)   FLManuallyRelease(&(__OBJ__))

    #define FLReleaseBlockWithNil(b)    _FLReleaseBlockWithNil((__BLOCK*) &(b))

    #define FLAssignObject(a,b)         _FLAssignObject((id*) &a, (id) b)
    #define FLCopyObject(a,b)           _FLCopyObject((id*) &a, (id) b)
    
    #define __bridge_fl
    #define __bridge_transfer_fl



#endif

#define fl_atomic 

@interface NSObject (FLCreateInstance)
+ (id) create;
@end
/*


\[([a-zA-Z. *_@*&^0-9\[\]\(\):]*)\ autorelease]

\1
*/

/*
\[([a-zA-Z. *_@*&^0-9\[\]\(\):]*)\
*/

// note to self
//return \[([A-Za-z_0-9:.\ \(\)\[\]]*)\ autorelease]

// regext to remove FLAlloc:
// find: FLAlloc\(([A-Za-z_0-9\[\]]*)\)
// replace: [\1 alloc]

// regext to add FLRelease:
// \[([a-zA-Z *@*&^0-9\[\]\(\):]*)\ release]
// FLRelease(\1)


// FLReturnAutoreleased\(([a-zA-Z *@*&^0-9\[\]\(\):]*)\)
// \1


