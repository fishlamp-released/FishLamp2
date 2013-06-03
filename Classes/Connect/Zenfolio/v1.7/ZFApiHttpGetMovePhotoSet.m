// 
// ZFApiHttpGetMovePhotoSet.m
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/2/13 4:12 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 


#import "ZFApiHttpGetMovePhotoSet.h"
#import "ZFMovePhotoSetHttpGetIn.h"
#import "FLModelObject.h"
#import "ZFMovePhotoSetHttpGetOut.h"

@implementation ZFApiHttpGetMovePhotoSet

+ (ZFApiHttpGetMovePhotoSet*) apiHttpGetMovePhotoSet {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_input release];
    [_output release];
    [super dealloc];
}
#endif
@synthesize input = _input;
- (NSString*) location {
    return @"http:/api.zenfolio.com/api/1.7/zfapi.asmx/MovePhotoSet";;
}
- (NSString*) operationName {
    return @"MovePhotoSet";;
}
@synthesize output = _output;
- (NSString*) targetNamespace {
    return @"http://www.zenfolio.com/api/1.7";;
}

@end
