// 
// FLCodeKeyValuePair.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/15/13 1:42 PM with PackMule (3.0.0.29)
// 
// Project: ObjectModel
// 

#import "FLModelObject.h"


@interface FLCodeKeyValuePair : FLModelObject<NSCopying> {
@private
    NSString* _key;
    NSString* _value;
}

@property (readwrite, strong, nonatomic) NSString* key;
@property (readwrite, strong, nonatomic) NSString* value;

+ (id) codeKeyValuePair;

@end