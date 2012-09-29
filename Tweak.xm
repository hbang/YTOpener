/**
 * YTOpener - open YouTube links in the new app
 *
 * By Ad@m <http://hbang.ws>
 * Licensed under the GPL license <http://www.gnu.org/copyleft/gpl.html>
 */

%hook SpringBoard
-(void)_openURLCore:(NSURL *)url display:(id)display publicURLsOnly:(BOOL)publicOnly animating:(BOOL)animated additionalActivationFlag:(unsigned int)flags {
	if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"vnd.youtube://"]]) {
		BOOL isMobile = NO;
		if (([[url scheme] isEqualToString:@"http"] || [[url scheme] isEqualToString:@"https"])
			&& ([[url host] isEqualToString:@"youtube.com"] || [[url host] isEqualToString:@"www.youtube.com"]
			|| (isMobile = [[url host] isEqualToString:@"m.youtube.com"]))
			&& isMobile ? [[url fragment] rangeOfString:@"/watch"].length > 0 : [[url path] isEqualToString:@"/watch"]) {
			NSArray *params = [(isMobile
				? [[url fragment] stringByReplacingOccurrencesOfString:@"/watch?" withString:@""]
				: [url query]) componentsSeparatedByString:@"&"];
			for (NSString *i in params)
				if ([i rangeOfString:@"v="].location == 0) {
					[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"vnd.youtube://" stringByAppendingString:
						[i stringByReplacingOccurrencesOfString:@"v=" withString:@""]]]];
					return;
				}
		} else if ([[url host] isEqualToString:@"youtu.be"] && [[url pathComponents] count] > 1) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"vnd.youtube://" stringByAppendingString:
				[[url pathComponents] objectAtIndex:1]]]];
			return;
		} else if ([[url scheme] isEqualToString:@"youtube"]) {
			[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[@"vnd." stringByAppendingString:[url absoluteString]]]];
			return;
		}
	}
	%orig;
}
%end
