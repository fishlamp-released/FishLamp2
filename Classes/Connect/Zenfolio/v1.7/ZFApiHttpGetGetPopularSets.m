// 
// ZFApiHttpGetGetPopularSets.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/3/13 10:43 AM with PackMule (3.0.1.100)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "ZFApiHttpGetGetPopularSets.h"
#import "FLModelObject.h"
#import "FLObjectDescriber.h"
#import "ZFGetPopularSetsHttpGetIn.h"
#import "ZFPhotoSet.h"

@implementation ZFApiHttpGetGetPopularSets

+ (ZFApiHttpGetGetPopularSets*) apiHttpGetGetPopularSets {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_input release];
    [_output release];
    [super dealloc];
}
#endif
+ (void) didRegisterObjectDescriber:(FLObjectDescriber*) describer {
    [describer addContainerType:[FLPropertyDescriber propertyDescriber:@"PhotoSet" propertyClass:[ZFPhotoSet class]] forContainerProperty:@"output"];
}
@synthesize input = _input;
- (NSString*) location {
    return @"http:/api.zenfolio.com/api/1.7/zfapi.asmx/GetPopularSets";;
}
- (NSString*) operationName {
    return @"GetPopularSets";;
}
@synthesize output = _output;
- (NSString*) targetNamespace {
    return @"http://www.zenfolio.com/api/1.7";;
}

@end
