/*
	TblTeamNameDto.h
	The interface definition of properties and methods for the TblTeamNameDto object.
	Generated by SudzC.com
*/

#import "Soap.h"
	

@interface TblTeamNameDto : SoapObject
{
	int _TeamId;
	NSString* _TeamName;
	
}
		
	@property int TeamId;
	@property (retain, nonatomic) NSString* TeamName;

	+ (TblTeamNameDto*) newWithNode: (CXMLNode*) node;
	- (id) initWithNode: (CXMLNode*) node;
	- (NSMutableString*) serialize;
	- (NSMutableString*) serialize: (NSString*) nodeName;
	- (NSMutableString*) serializeAttributes;
	- (NSMutableString*) serializeElements;

@end
