/*
	TblFixtureDto.h
	The implementation of properties and methods for the TblFixtureDto object.
	Generated by SudzC.com
*/
#import "TblFixtureDto.h"

@implementation TblFixtureDto
	@synthesize AwayTeamName = _AwayTeamName;
	@synthesize AwayTeamScore = _AwayTeamScore;
	@synthesize FixtureDate = _FixtureDate;
	@synthesize FixtureId = _FixtureId;
	@synthesize HomeTeamName = _HomeTeamName;
	@synthesize HomeTeamScore = _HomeTeamScore;
	@synthesize IsCancelled = _IsCancelled;
	@synthesize IsPlayed = _IsPlayed;
	@synthesize Report = _Report;
	@synthesize TipOffTime = _TipOffTime;

	- (id) init
	{
		if(self = [super init])
		{
			self.AwayTeamName = nil;
			self.AwayTeamScore = nil;
			self.FixtureDate = nil;
			self.HomeTeamName = nil;
			self.HomeTeamScore = nil;
			self.Report = nil;
			self.TipOffTime = nil;

		}
		return self;
	}

	+ (TblFixtureDto*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (TblFixtureDto*)[[TblFixtureDto alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.AwayTeamName = [Soap getNodeValue: node withName: @"AwayTeamName"];
			self.AwayTeamScore = [Soap getNodeValue: node withName: @"AwayTeamScore"];
			self.FixtureDate = [Soap dateFromString: [Soap getNodeValue: node withName: @"FixtureDate"]];
			self.FixtureId = [[Soap getNodeValue: node withName: @"FixtureId"] intValue];
			self.HomeTeamName = [Soap getNodeValue: node withName: @"HomeTeamName"];
			self.HomeTeamScore = [Soap getNodeValue: node withName: @"HomeTeamScore"];
			self.IsCancelled = [[Soap getNodeValue: node withName: @"IsCancelled"] boolValue];
			self.IsPlayed = [[Soap getNodeValue: node withName: @"IsPlayed"] boolValue];
			self.Report = [Soap getNodeValue: node withName: @"Report"];
			self.TipOffTime = [Soap getNodeValue: node withName: @"TipOffTime"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"FixtureDto"];
	}
  
	- (NSMutableString*) serialize: (NSString*) nodeName
	{
		NSMutableString* s = [NSMutableString string];
		[s appendFormat: @"<%@", nodeName];
		[s appendString: [self serializeAttributes]];
		[s appendString: @">"];
		[s appendString: [self serializeElements]];
		[s appendFormat: @"</%@>", nodeName];
		return s;
	}
	
	- (NSMutableString*) serializeElements
	{
		NSMutableString* s = [super serializeElements];
		if (self.AwayTeamName != nil) [s appendFormat: @"<AwayTeamName>%@</AwayTeamName>", [[self.AwayTeamName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.AwayTeamScore != nil) [s appendFormat: @"<AwayTeamScore>%@</AwayTeamScore>", [[self.AwayTeamScore stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.FixtureDate != nil) [s appendFormat: @"<FixtureDate>%@</FixtureDate>", [Soap getDateString: self.FixtureDate]];
		[s appendFormat: @"<FixtureId>%@</FixtureId>", [NSString stringWithFormat: @"%i", self.FixtureId]];
		if (self.HomeTeamName != nil) [s appendFormat: @"<HomeTeamName>%@</HomeTeamName>", [[self.HomeTeamName stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.HomeTeamScore != nil) [s appendFormat: @"<HomeTeamScore>%@</HomeTeamScore>", [[self.HomeTeamScore stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		[s appendFormat: @"<IsCancelled>%@</IsCancelled>", (self.IsCancelled)?@"true":@"false"];
		[s appendFormat: @"<IsPlayed>%@</IsPlayed>", (self.IsPlayed)?@"true":@"false"];
		if (self.Report != nil) [s appendFormat: @"<Report>%@</Report>", [[self.Report stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.TipOffTime != nil) [s appendFormat: @"<TipOffTime>%@</TipOffTime>", [[self.TipOffTime stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[TblFixtureDto class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end
