
#import "FLDatabase.h"

@interface FLDatabase ()
- (void) throwSqliteError:(const char*) sql;
@end

@interface FLDatabase (ObjectsInternal)
- (void) _saveOneObject:(id) object;
@end

@interface FLDatabase (VersioningInternal)
- (void) initializeVersioning;
- (void) writeHistoryForTable:(FLDatabaseTable*) table entry:(NSString*) entry;
@end

extern NSString* FLDatabaseTypeToString(FLDatabaseType type);
extern NSString* FLDatabaseErrorToString(int error);
