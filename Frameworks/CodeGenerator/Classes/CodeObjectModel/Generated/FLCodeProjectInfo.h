// 
// FLCodeProjectInfo.h
// 
// DO NOT MODIFY!! Modifications will be overwritten.
// Generated by: Mike Fullerton @ 6/15/13 1:42 PM with PackMule (3.0.0.29)
// 
// Project: ObjectModel
// 

#import "FLModelObject.h"

@class FLCodeCompany;

@interface FLCodeProjectInfo : FLModelObject {
@private
    FLCodeCompany* _organization;
    NSString* _license;
    NSString* _projectName;
    NSString* _schemaName;
}

@property (readwrite, strong, nonatomic) NSString* license;
@property (readwrite, strong, nonatomic) FLCodeCompany* organization;
@property (readwrite, strong, nonatomic) NSString* projectName;
@property (readwrite, strong, nonatomic) NSString* schemaName;

+ (id) codeProjectInfo;

@end