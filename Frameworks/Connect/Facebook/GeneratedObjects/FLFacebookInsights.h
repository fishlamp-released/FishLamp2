// 
// FLFacebookInsights.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// 
// Project: FishLamp Connect
// Schema: FishLampFacebook
// 
// Generated by: Mike Fullerton @ 5/12/13 8:01 PM with PackMule (3.0.0.1)
// 
// Organization: GreenTongue Software, LLC
// 
// Copywrite (C) 2013 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
// 
#import "FLModelObject.h"
@interface FLFacebookInsights : FLModelObject {
@private
    NSString* _period;
    NSMutableArray* _values;
}

@property (readwrite, strong, nonatomic) NSString* period;
@property (readwrite, strong, nonatomic) NSMutableArray* values;
+(FLFacebookInsights) insights;
@end
