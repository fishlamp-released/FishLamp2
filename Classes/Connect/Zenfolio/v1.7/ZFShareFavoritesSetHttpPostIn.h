// 
// ZFShareFavoritesSetHttpPostIn.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/30/13 6:24 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@interface ZFShareFavoritesSetHttpPostIn : FLModelObject {
@private
    NSString* _sharerName;
    NSString* _sharerMessage;
    NSString* _favoritesSetId;
    NSString* _favoritesSetName;
    NSString* _sharerEmail;
}

@property (readwrite, strong, nonatomic) NSString* sharerName;
@property (readwrite, strong, nonatomic) NSString* sharerMessage;
@property (readwrite, strong, nonatomic) NSString* favoritesSetId;
@property (readwrite, strong, nonatomic) NSString* favoritesSetName;
@property (readwrite, strong, nonatomic) NSString* sharerEmail;
+ (ZFShareFavoritesSetHttpPostIn*) shareFavoritesSetHttpPostIn;
@end
