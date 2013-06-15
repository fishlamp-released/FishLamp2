// 
// FLCodeCodeSnippet.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/15/13 1:42 PM with PackMule (3.0.0.29)
// 
// Project: ObjectModel
// 

#import "FLModelObject.h"


@interface FLCodeCodeSnippet : FLModelObject<NSCopying> {
@private
    NSString* _scopedBy;
    NSString* _comment;
    NSString* _name;
    NSString* _lines;
}

@property (readwrite, strong, nonatomic) NSString* comment;
@property (readwrite, strong, nonatomic) NSString* lines;
@property (readwrite, strong, nonatomic) NSString* name;
@property (readwrite, strong, nonatomic) NSString* scopedBy;

+ (id) codeCodeSnippet;

@end