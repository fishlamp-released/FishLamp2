// 
// ZFApiHttpPostGetPopularSets.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 2:36 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
#import "FLHttpRequestDescriptor.h"
@class ZFPhotoSet;
@class FLObjectDescriber;
@class ZFGetPopularSetsHttpPostIn;
@interface ZFApiHttpPostGetPopularSets : FLModelObject<FLHttpRequestDescriptor> {
@private
    ZFGetPopularSetsHttpPostIn* _input;
    NSMutableArray* _output;
}

@property (readonly, strong, nonatomic) NSString* targetNamespace;
@property (readwrite, strong, nonatomic) ZFGetPopularSetsHttpPostIn* input;
@property (readwrite, strong, nonatomic) NSMutableArray* output;
@property (readonly, strong, nonatomic) NSString* location;
@property (readonly, strong, nonatomic) NSString* operationName;
+(ZFApiHttpPostGetPopularSets*) apiHttpPostGetPopularSets;
@end
