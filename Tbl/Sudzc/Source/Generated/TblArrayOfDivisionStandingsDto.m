/*
	TblArrayOfDivisionStandingsDto.h
	The implementation of properties and methods for the TblArrayOfDivisionStandingsDto array.
	Generated by SudzC.com
*/
#import "TblArrayOfDivisionStandingsDto.h"

#import "TblDivisionStandingsDto.h"
@implementation TblArrayOfDivisionStandingsDto

	+ (id) newWithNode: (CXMLNode*) node
	{
		return [[TblArrayOfDivisionStandingsDto alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node
	{
		if(self = [self init]) {
			for(CXMLElement* child in [node children])
			{
				TblDivisionStandingsDto* value = [[TblDivisionStandingsDto newWithNode: child] object];
				if(value != nil) {
					[self addObject: value];
				}
			}
		}
		return self;
	}
	
	+ (NSMutableString*) serialize: (NSArray*) array
	{
		NSMutableString* s = [NSMutableString string];
		for(id item in array) {
			[s appendString: [item serialize: @"DivisionStandingsDto"]];
		}
		return s;
	}
@end