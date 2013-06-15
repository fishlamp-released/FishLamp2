// 
// FLCodeType.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/15/13 1:42 PM with PackMule (3.0.0.29)
// 
// Project: ObjectModel
// 

#import "FLModelObject.h"


@interface FLCodeType : FLModelObject<NSCopying> {
@private
    NSString* _typeNameUnmodified;
    NSString* _typeName;
    NSString* _defaultValue;
}

@property (readwrite, strong, nonatomic) NSString* defaultValue;
@property (readwrite, strong, nonatomic) NSString* typeName;
@property (readwrite, strong, nonatomic) NSString* typeNameUnmodified;

+ (id) codeType;

@end