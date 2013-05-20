//	This file was generated at 7/3/11 10:38 AM by PackMule. DO NOT MODIFY!!
//
//	GtSoapFault11.h
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtSoapFault11
// --------------------------------------------------------------------
@interface GtSoapFault11 : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_faultcode;
	NSString* m_faultstring;
	NSString* m_faultactor;
	NSString* m_detail;
} 


@property (readwrite, retain, nonatomic) NSString* detail;

@property (readwrite, retain, nonatomic) NSString* faultactor;

@property (readwrite, retain, nonatomic) NSString* faultcode;

@property (readwrite, retain, nonatomic) NSString* faultstring;

+ (NSString*) detailKey;

+ (NSString*) faultactorKey;

+ (NSString*) faultcodeKey;

+ (NSString*) faultstringKey;

+ (GtSoapFault11*) soapFault11; 

@end

@interface GtSoapFault11 (ValueProperties) 
@end

