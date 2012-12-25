//
//  FLServiceMessage.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLServiceRequest.h"


NSString* const FLServiceTypeCache          = @"com.fishlamp.service.cache";
NSString* const FLServiceTypeStorage        = @"com.fishlamp.service.storage";
NSString* const FLServiceTypeNetworkServer  = @"com.fishlamp.service.server";

NSString* const FLServiceRequestTypeCreate  = @"com.fishlamp.service.request.create";
NSString* const FLServiceRequestTypeRead    = @"com.fishlamp.service.request.read";
NSString* const FLServiceRequestTypeUpdate  = @"com.fishlamp.service.request.update";
NSString* const FLServiceRequestTypeDelete  = @"com.fishlamp.service.request.delete";
NSString* const FLServiceRequestTypeFind    = @"com.fishlamp.service.request.find";

@interface FLServiceRequest ()
@property (readwrite, strong, nonatomic) id requestType;
@property (readwrite, strong, nonatomic) id serviceType;
@property (readwrite, strong, nonatomic) NSDictionary* arguments;

//- (void) addArguments:(id) firstArgument args:(va_list) args;
//- (void) setArgument:(id) argument forKey:(id) key;
//- (void) addArguments:(id)firstArgument, ... NS_REQUIRES_NIL_TERMINATION;

@end

@implementation FLServiceRequest

@synthesize arguments = _arguments;
@synthesize serviceType = _serviceType;
@synthesize requestType = _actionType;

void _FLAddArgsToDictionary(NSMutableDictionary* dict, id firstArgument, va_list valist) {
    if(firstArgument) {
        id argument = firstArgument;

		id obj = nil;
        while ((obj = va_arg(valist, id))) { 
            if(argument) {
                [dict setObject:argument forKey:obj];
                argument = nil;
            }
            else {
                argument = obj;
            }
        }
    }
}

#define FLAddArgsToDictionary(__DICT__, __FIRST__) \
        if(__FIRST__) { \
            va_list valist; \
            va_start(valist, __FIRST__); \
            _FLAddArgsToDictionary(__DICT__, __FIRST__, valist); \
            va_end(valist); \
        }

- (id) initWithServiceType:(id) serviceType 
               requestType:(id) requestType
               argumentsNoCopy:(NSDictionary*) arguments {

    self = [super init];
    if(self) {
        self.serviceType = serviceType;
        self.requestType = requestType;
        self.arguments = arguments;
    }
    
    return self;
}

- (id) initWithServiceType:(id) serviceType 
               requestType:(id) requestType
               arguments:(NSDictionary*) dictionary {
    
    return [self initWithServiceType:serviceType 
                         requestType:requestType 
                     argumentsNoCopy:FLAutorelease([dictionary mutableCopy])];
}               

- (id) initWithServiceType:(id) serviceType 
               requestType:(id) requestType
                  argument:(id) firstArgument, ... {

    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    FLAddArgsToDictionary(dict, firstArgument);
    return [self initWithServiceType:serviceType 
                         requestType:requestType 
                     argumentsNoCopy:dict];
}

- (id) initWithServiceType:(id) serviceType 
               requestType:(id) requestType {
    
    return [self initWithServiceType:serviceType 
                         requestType:requestType 
                     argumentsNoCopy:nil];
}               

- (id) initWithServiceType:(id) serviceType 
               requestType:(id) requestType
                  argument:(id) argument
               argumentKey:(id) argumentKey {

    return [self initWithServiceType:serviceType 
                         requestType:requestType 
                     argumentsNoCopy:[NSDictionary dictionaryWithObject:argument forKey:argumentKey]];
}        

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_requestType forKey:@"requestType"];
    [aCoder encodeObject:_serviceType forKey:@"serviceType"];
    if(_arguments) {
        [aCoder encodeObject:_arguments forKey:@"arguments"];
    }
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if(self) {
    	self.serviceType = [aDecoder decodeObjectForKey:@"serviceType"];
    	self.requestType = [aDecoder decodeObjectForKey:@"requestType"];
        self.arguments = [aDecoder decodeObjectForKey:@"arguments"];
	}
    
    return self;
}

+ (id) serviceRequest {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) serviceRequest:(id) serviceType 
          requestType:(id) requestType  {
    return FLAutorelease([[[self class] alloc] initWithServiceType:serviceType 
                                                       requestType:requestType]);
}

#if FL_MRC
- (void) dealloc {
    [_arguments release];
    [_requestType release];
    [_serviceType release];
    [super dealloc];
}
#endif
+ (id) serviceRequest:(id) serviceType 
          requestType:(id) requestType
             argument:(id) firstArgument, ... {
        
    NSMutableDictionary* dict = [NSMutableDictionary dictionary];
    FLAddArgsToDictionary(dict, firstArgument);
    return FLAutorelease([[[self class] alloc] initWithServiceType:serviceType 
                                                       requestType:requestType 
                                                   argumentsNoCopy:dict]);
}        

+ (id) serviceRequest:(id) serviceType 
          requestType:(id) requestType
             argument:(id) argument
          argumentKey:(id) argumentKey {

    return FLAutorelease([[[self class] alloc] initWithServiceType:serviceType 
                                                       requestType:requestType 
                                                          argument:argument
                                                       argumentKey:argumentKey]);
} 
        
//- (void) setArgument:(id) argument forKey:(id) key {
//    if(!_arguments) {
//        _arguments = [[NSMutableDictionary alloc] init];
//    }
//    
//    [_arguments setObject:argument forKey:key];
//}

- (id) argumentForKey:(id) key {
    return [_arguments objectForKey:key];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len {
    
    return [_arguments countByEnumeratingWithState:state objects:buffer count:len];
}

- (id)copyWithZone:(NSZone *)zone {
    return [[FLServiceRequest alloc] initWithServiceType:self.serviceType 
                                             requestType:self.requestType 
                                               arguments:self.arguments];
}



@end

//@implementation FLReadServiceRequest : FLServiceRequest
//+ (id) readServiceRequest:(id) key serviceType:(id) serviceType;
//@end
//
//@implementation FLWriteServiceRequest : FLServiceRequest
//+ (id) writeServiceRequest:(id) object serviceType:(id) serviceType;
//@end
