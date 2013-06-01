// 
// ZFShareFavoritesSet.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 5/31/13 7:38 PM with PackMule (3.0.0.1)
// 
// Project: Zenfolio Web API
// Schema: ZenfolioWebApi
// 
// Copyright 2013 (c) GreenTongue Software LLC, Mike Fullerton
// The FishLamp Framework is released under the MIT License: http://fishlamp.com/license
// 

#import "FLModelObject.h"
@interface ZFShareFavoritesSet : FLModelObject {
@private
    NSString* _sharerName;
    NSString* _sharerMessage;
    long _favoritesSetId;
    NSString* _favoritesSetName;
    NSString* _sharerEmail;
}

@property (readwrite, strong, nonatomic) NSString* sharerName;
@property (readwrite, strong, nonatomic) NSString* sharerMessage;
@property (readwrite, assign, nonatomic) long favoritesSetId;
@property (readwrite, strong, nonatomic) NSString* favoritesSetName;
@property (readwrite, strong, nonatomic) NSString* sharerEmail;
+ (ZFShareFavoritesSet*) shareFavoritesSet;
@end
