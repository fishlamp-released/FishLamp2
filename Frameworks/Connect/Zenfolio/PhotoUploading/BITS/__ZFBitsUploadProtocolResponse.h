//	This file was generated at 8/31/11 1:04 PM by PackMule. DO NOT MODIFY!!
//
//	ZFBitsUploadProtocolResponse.h
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// ZFBitsUploadProtocolResponse
// --------------------------------------------------------------------
@interface ZFBitsUploadProtocolResponse : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* _packetType;
	NSString* _protocol;
	NSString* _sessionId;
	NSString* _hostId;
	NSString* _hostIdFallbackTimeout;
	NSString* _errorCode;
	NSString* _errorContext;
	NSString* _replyURL;
	NSString* _received;
	NSString* _acceptEncoding;
	NSString* _receivedContentRange;
} 


@property (readwrite, retain, nonatomic) NSString* acceptEncoding;

@property (readwrite, retain, nonatomic) NSString* errorCode;

@property (readwrite, retain, nonatomic) NSString* errorContext;

@property (readwrite, retain, nonatomic) NSString* hostId;

@property (readwrite, retain, nonatomic) NSString* hostIdFallbackTimeout;

@property (readwrite, retain, nonatomic) NSString* packetType;

@property (readwrite, retain, nonatomic) NSString* protocol;

@property (readwrite, retain, nonatomic) NSString* received;

@property (readwrite, retain, nonatomic) NSString* receivedContentRange;

@property (readwrite, retain, nonatomic) NSString* replyURL;

@property (readwrite, retain, nonatomic) NSString* sessionId;

+ (NSString*) acceptEncodingKey;

+ (NSString*) errorCodeKey;

+ (NSString*) errorContextKey;

+ (NSString*) hostIdFallbackTimeoutKey;

+ (NSString*) hostIdKey;

+ (NSString*) packetTypeKey;

+ (NSString*) protocolKey;

+ (NSString*) receivedContentRangeKey;

+ (NSString*) receivedKey;

+ (NSString*) replyURLKey;

+ (NSString*) sessionIdKey;

+ (ZFBitsUploadProtocolResponse*) bitsUploadProtocolResponse; 

@end

@interface ZFBitsUploadProtocolResponse (ValueProperties) 
@end
