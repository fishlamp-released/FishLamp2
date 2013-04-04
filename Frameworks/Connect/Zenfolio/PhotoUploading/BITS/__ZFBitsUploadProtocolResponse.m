//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFBitsUploadProtocolResponse.m
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFBitsUploadProtocolResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFBitsUploadProtocolResponse


@synthesize acceptEncoding = _acceptEncoding;
@synthesize errorCode = _errorCode;
@synthesize errorContext = _errorContext;
@synthesize hostId = _hostId;
@synthesize hostIdFallbackTimeout = _hostIdFallbackTimeout;
@synthesize packetType = _packetType;
@synthesize protocol = _protocol;
@synthesize received = _received;
@synthesize receivedContentRange = _receivedContentRange;
@synthesize replyURL = _replyURL;
@synthesize sessionId = _sessionId;

+ (NSString*) acceptEncodingKey
{
	return @"acceptEncoding";
}

+ (NSString*) errorCodeKey
{
	return @"errorCode";
}

+ (NSString*) errorContextKey
{
	return @"errorContext";
}

+ (NSString*) hostIdFallbackTimeoutKey
{
	return @"hostIdFallbackTimeout";
}

+ (NSString*) hostIdKey
{
	return @"hostId";
}

+ (NSString*) packetTypeKey
{
	return @"packetType";
}

+ (NSString*) protocolKey
{
	return @"protocol";
}

+ (NSString*) receivedContentRangeKey
{
	return @"receivedContentRange";
}

+ (NSString*) receivedKey
{
	return @"received";
}

+ (NSString*) replyURLKey
{
	return @"replyURL";
}

+ (NSString*) sessionIdKey
{
	return @"sessionId";
}

+ (ZFBitsUploadProtocolResponse*) bitsUploadProtocolResponse
{
	return FLAutorelease([[ZFBitsUploadProtocolResponse alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFBitsUploadProtocolResponse*)object).hostId = FLCopyOrRetainObject(_hostId);
	((ZFBitsUploadProtocolResponse*)object).protocol = FLCopyOrRetainObject(_protocol);
	((ZFBitsUploadProtocolResponse*)object).errorCode = FLCopyOrRetainObject(_errorCode);
	((ZFBitsUploadProtocolResponse*)object).acceptEncoding = FLCopyOrRetainObject(_acceptEncoding);
	((ZFBitsUploadProtocolResponse*)object).receivedContentRange = FLCopyOrRetainObject(_receivedContentRange);
	((ZFBitsUploadProtocolResponse*)object).sessionId = FLCopyOrRetainObject(_sessionId);
	((ZFBitsUploadProtocolResponse*)object).received = FLCopyOrRetainObject(_received);
	((ZFBitsUploadProtocolResponse*)object).errorContext = FLCopyOrRetainObject(_errorContext);
	((ZFBitsUploadProtocolResponse*)object).packetType = FLCopyOrRetainObject(_packetType);
	((ZFBitsUploadProtocolResponse*)object).replyURL = FLCopyOrRetainObject(_replyURL);
	((ZFBitsUploadProtocolResponse*)object).hostIdFallbackTimeout = FLCopyOrRetainObject(_hostIdFallbackTimeout);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_packetType);
	FLRelease(_protocol);
	FLRelease(_sessionId);
	FLRelease(_hostId);
	FLRelease(_hostIdFallbackTimeout);
	FLRelease(_errorCode);
	FLRelease(_errorContext);
	FLRelease(_replyURL);
	FLRelease(_received);
	FLRelease(_acceptEncoding);
	FLRelease(_receivedContentRange);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_packetType) [aCoder encodeObject:_packetType forKey:@"_packetType"];
	if(_protocol) [aCoder encodeObject:_protocol forKey:@"_protocol"];
	if(_sessionId) [aCoder encodeObject:_sessionId forKey:@"_sessionId"];
	if(_hostId) [aCoder encodeObject:_hostId forKey:@"_hostId"];
	if(_hostIdFallbackTimeout) [aCoder encodeObject:_hostIdFallbackTimeout forKey:@"_hostIdFallbackTimeout"];
	if(_errorCode) [aCoder encodeObject:_errorCode forKey:@"_errorCode"];
	if(_errorContext) [aCoder encodeObject:_errorContext forKey:@"_errorContext"];
	if(_replyURL) [aCoder encodeObject:_replyURL forKey:@"_replyURL"];
	if(_received) [aCoder encodeObject:_received forKey:@"_received"];
	if(_acceptEncoding) [aCoder encodeObject:_acceptEncoding forKey:@"_acceptEncoding"];
	if(_receivedContentRange) [aCoder encodeObject:_receivedContentRange forKey:@"_receivedContentRange"];
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
	if((self = [super init]))
	{
		_packetType = FLRetain([aDecoder decodeObjectForKey:@"_packetType"]);
		_protocol = FLRetain([aDecoder decodeObjectForKey:@"_protocol"]);
		_sessionId = FLRetain([aDecoder decodeObjectForKey:@"_sessionId"]);
		_hostId = FLRetain([aDecoder decodeObjectForKey:@"_hostId"]);
		_hostIdFallbackTimeout = FLRetain([aDecoder decodeObjectForKey:@"_hostIdFallbackTimeout"]);
		_errorCode = FLRetain([aDecoder decodeObjectForKey:@"_errorCode"]);
		_errorContext = FLRetain([aDecoder decodeObjectForKey:@"_errorContext"]);
		_replyURL = FLRetain([aDecoder decodeObjectForKey:@"_replyURL"]);
		_received = FLRetain([aDecoder decodeObjectForKey:@"_received"]);
		_acceptEncoding = FLRetain([aDecoder decodeObjectForKey:@"_acceptEncoding"]);
		_receivedContentRange = FLRetain([aDecoder decodeObjectForKey:@"_receivedContentRange"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer addChildDescriberWithName:@"packetType" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"protocol" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"sessionId" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"hostId" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"hostIdFallbackTimeout" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"errorCode" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"errorContext" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"replyURL" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"received" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"acceptEncoding" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"receivedContentRange" withClass:[NSString class]];
	});
	return s_describer;
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		FLDatabaseTable* superTable = [super sharedDatabaseTable];
		if(superTable)
		{
			s_table = [superTable copy];
			s_table.tableName = [self databaseTableName];
		}
		else
		{
			s_table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
		}
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"packetType" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"protocol" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sessionId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"hostId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"hostIdFallbackTimeout" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"errorCode" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"errorContext" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"replyURL" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"received" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"acceptEncoding" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"receivedContentRange" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFBitsUploadProtocolResponse (ValueProperties) 
@end

