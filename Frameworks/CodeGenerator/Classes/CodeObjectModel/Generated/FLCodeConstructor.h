// 
// FLCodeConstructor.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/15/13 1:42 PM with PackMule (3.0.0.29)
// 
// Project: ObjectModel
// 

#import "FLModelObject.h"

@class FLCodeVariable;
@class FLObjectDescriber;
@class FLCodeLine;

@interface FLCodeConstructor : FLModelObject {
@private
    NSMutableArray* _lines;
    NSMutableArray* _parameters;
}

@property (readwrite, strong, nonatomic) NSMutableArray* lines;
@property (readwrite, strong, nonatomic) NSMutableArray* parameters;

+ (id) codeConstructor;

@end
