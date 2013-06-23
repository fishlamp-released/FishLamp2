


NS_INLINE
id _FLSetObjectWithCopy(id __strong * a, id b) {
    if(a && (*a != b)) { 
        id temp = FLAutorelease(*a);
        *a = [b copy]; 
        return temp;
    }
    
    return nil;
}

NS_INLINE
id _FLSetObjectWithMutableCopy(id __strong * a, id b) {
    if(a && (*a != b)) { 
        id temp = FLAutorelease(*a);
        *a = [b mutableCopy]; 
        return temp;
    }
    
    return nil;
}

NS_INLINE
id _FLSetObjectWithRetain(id __strong * a, id b) {
    if(a && (*a != b)) { 
        id temp = FLAutorelease(*a);
        *a = FLRetain(b); 
        return temp;
    }
    
    return nil;
}

NS_INLINE
id _FLSwap(id __strong * a, id __strong * b) {
    if(a && b) {
        id temp = *a;
        *a = *b;
        *b = temp;
        return FLAutorelease(FLRetain(temp));
    }
    
    return nil;
} 

NS_INLINE
id _FLReleaseWithNil(id __strong * obj) {
    if(obj && *obj) {
        id temp = FLAutorelease(*obj);
        *obj = nil;
        return temp;
    }
    
    return nil;
}

#define FLReleaseWithNil(__OBJ__) \
            _FLReleaseWithNil(&__OBJ__)

#define FLSetObjectWithRetain(a,b) \
            _FLSetObjectWithRetain((id*) &a, (id) b)

#define FLSetObjectWithCopy(a,b) \
            _FLSetObjectWithCopy((id*) &a, (id) b)

#define FLSetObjectWithMutableCopy(a,b) \
            _FLSetObjectWithMutableCopy((id*) &a, (id) b)

#define FLCopyWithAutorelease(__OBJECT__) \
            FLAutorelease([((id)__OBJECT__) copy])

#define FLMutableCopyWithAutorelease(__OBJECT__) \
            FLAutorelease([((id)__OBJECT__) mutableCopy])

#define FLRetainWithAutorelease(__OBJECT__) \
            FLAutorelease(FLRetain(__OBJECT__))

#define FLSwap(a, b) \
            _FLSwap(&a, &b)

// so you can do this:
// id oldFoo = FLSetProperty(obj.foo, newFoo);
#define FLSetProperty(__PROP__, __VALUE__) \
            FLRetainWithAutorelease(__PROP__); __PROP__ = __VALUE__

// remember these are PROPERTIES so each getter/setter is only called once.
// not sure how useful this actually is though.
#define FLSwapProperty(__PROP__, __VALUE__) \
        do { \
            id __PROP_TEMP__ = FLRetainWithAutorelease(__PROP__); \
            __PROP__ = __VALUE__; \
            __VALUE__ = __PROP_TEMP__; \
        } while(0)

//#define FLSafeguardBlock(__BLOCK__) do { __BLOCK__ = FLCopyWithAutorelease(__BLOCK__); } while(0)

//
// AutoreleasePool
//

#define FLAutoreleasePoolWithName(__NAME__, __VA_ARGS__) \
            FLAutoreleasePoolOpen(__NAME__) \
            __VA_ARGS__ \
            FLAutoreleasePoolClose(__NAME__)          

#define FLAutoreleasePool(__VA_ARGS__) \
            FLAutoreleasePoolOpen(pool) \
            __VA_ARGS__ \
            FLAutoreleasePoolClose(pool)

extern id FLCopyOrRetainObject(id src);
