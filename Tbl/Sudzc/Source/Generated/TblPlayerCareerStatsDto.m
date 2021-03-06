/*
	TblPlayerCareerStatsDto.h
	The implementation of properties and methods for the TblPlayerCareerStatsDto object.
	Generated by SudzC.com
*/
#import "TblPlayerCareerStatsDto.h"

@implementation TblPlayerCareerStatsDto
	@synthesize Fouls = _Fouls;
	@synthesize FoulsPerGame = _FoulsPerGame;
	@synthesize Games = _Games;
	@synthesize MvpAwards = _MvpAwards;
	@synthesize Points = _Points;
	@synthesize PointsPerGame = _PointsPerGame;
	@synthesize Year = _Year;

	- (id) init
	{
		if(self = [super init])
		{
			self.Fouls = nil;
			self.FoulsPerGame = nil;
			self.Games = nil;
			self.MvpAwards = nil;
			self.Points = nil;
			self.PointsPerGame = nil;
			self.Year = nil;

		}
		return self;
	}

	+ (TblPlayerCareerStatsDto*) newWithNode: (CXMLNode*) node
	{
		if(node == nil) { return nil; }
		return (TblPlayerCareerStatsDto*)[[TblPlayerCareerStatsDto alloc] initWithNode: node];
	}

	- (id) initWithNode: (CXMLNode*) node {
		if(self = [super initWithNode: node])
		{
			self.Fouls = [Soap getNodeValue: node withName: @"Fouls"];
			self.FoulsPerGame = [Soap getNodeValue: node withName: @"FoulsPerGame"];
			self.Games = [Soap getNodeValue: node withName: @"Games"];
			self.MvpAwards = [Soap getNodeValue: node withName: @"MvpAwards"];
			self.Points = [Soap getNodeValue: node withName: @"Points"];
			self.PointsPerGame = [Soap getNodeValue: node withName: @"PointsPerGame"];
			self.Year = [Soap getNodeValue: node withName: @"Year"];
		}
		return self;
	}

	- (NSMutableString*) serialize
	{
		return [self serialize: @"PlayerCareerStatsDto"];
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
		if (self.Fouls != nil) [s appendFormat: @"<Fouls>%@</Fouls>", [[self.Fouls stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.FoulsPerGame != nil) [s appendFormat: @"<FoulsPerGame>%@</FoulsPerGame>", [[self.FoulsPerGame stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.Games != nil) [s appendFormat: @"<Games>%@</Games>", [[self.Games stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.MvpAwards != nil) [s appendFormat: @"<MvpAwards>%@</MvpAwards>", [[self.MvpAwards stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.Points != nil) [s appendFormat: @"<Points>%@</Points>", [[self.Points stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.PointsPerGame != nil) [s appendFormat: @"<PointsPerGame>%@</PointsPerGame>", [[self.PointsPerGame stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];
		if (self.Year != nil) [s appendFormat: @"<Year>%@</Year>", [[self.Year stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"] stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"]];

		return s;
	}
	
	- (NSMutableString*) serializeAttributes
	{
		NSMutableString* s = [super serializeAttributes];

		return s;
	}
	
	-(BOOL)isEqual:(id)object{
		if(object != nil && [object isKindOfClass:[TblPlayerCareerStatsDto class]]) {
			return [[self serialize] isEqualToString:[object serialize]];
		}
		return NO;
	}
	
	-(NSUInteger)hash{
		return [Soap generateHash:self];

	}

@end
