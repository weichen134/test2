//
//  WebServices.m
//  navag
//
//  Created by DY LOU on 10-4-10.
//  Copyright 2010 Zhejiang Dayu Information Technology Co.,Ltd. All rights reserved.
//

#import "WebServices.h"
#import "StringEncryption.h"
#import "NSData+Base64.h"


@implementation WebServices
NSString *_key = @"3d5900ae-111a-45be-96b3-d9e4606ca793";

+(NSURL *)getRestUrl:(NSString *)url Function:(NSString *) methodName Parameter:(NSString *) params
{		
	//keyStr
	NSString *keyStr = @"";
	
	//PART A--fetch up the sys time as the style in 2011-05-29 16:20:51
	NSDate *timeStr=[NSDate date];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
	NSString *partTime = [dateFormat stringFromDate:timeStr];
	keyStr=[keyStr stringByAppendingString:partTime];
    
	//PART B--fetch up the UDID
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *mobile = [defaults objectForKey:@"MOBILE"];
	keyStr=[keyStr stringByAppendingString:@"&"];
	keyStr=[keyStr stringByAppendingString:mobile];
    
	//PART C--compose the value as idenfitier of '|'
	if ([params length]>0) {
		keyStr=[keyStr stringByAppendingString:@"&"];
		keyStr=[keyStr stringByAppendingString:params];
	}
	//NSLog(@"Before cry:%@",keyStr);
	//Encypt the keyStr
	StringEncryption *cry =[[StringEncryption alloc] init];
	NSData *keyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding];
    
	CCOptions padding = kCCOptionPKCS7Padding;
	
	NSData *keyCryData = [cry encrypt:keyData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
    
	NSString *cryStr = [keyCryData base64EncodingWithLineLength:0];
	//NSLog(@"After cry: %@",cryStr);
	//change the url as the urlcode
	NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
																				   (CFStringRef)cryStr,
																				   NULL,
																				   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																				   kCFStringEncodingUTF8 ));
    //NSLog(@"%@",encodedString);
	
	//default webservice url ----use it as the total str
	NSString *myNewURL = [NSString stringWithFormat:@"%@%@?key=%@",url,methodName,encodedString];
	
    //NSLog(myNewURL);
	
	return [NSURL URLWithString:(NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)myNewURL, NULL, NULL, kCFStringEncodingUTF8))];
}

//2015 create
+(NSURL *)getSRestUrl:(NSString *)url Function:(NSString *) methodName withMobile:(NSString *)mobile;
{
	//keyStr
	NSString *keyStr = @"";
	
	//PART A--fetch up the sys time as the style in 2011-05-29 16:20:51
	NSDate *timeStr=[NSDate date];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
	NSString *partTime = [dateFormat stringFromDate:timeStr];
	keyStr=[keyStr stringByAppendingString:partTime];
    
	//PART B--fetch up the UDID
	keyStr=[keyStr stringByAppendingString:@"&"];
	keyStr=[keyStr stringByAppendingString:mobile];

	//NSLog(@"Before cry:%@",keyStr);
	//Encypt the keyStr
	StringEncryption *cry =[[StringEncryption alloc] init];
	NSData *keyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding];
    
	CCOptions padding = kCCOptionPKCS7Padding;
	
	NSData *keyCryData = [cry encrypt:keyData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
    
	NSString *cryStr = [keyCryData base64EncodingWithLineLength:0];
	//NSLog(@"After cry: %@",cryStr);
	//change the url as the urlcode
	NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
																				   (CFStringRef)cryStr,
																				   NULL,
																				   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																				   kCFStringEncodingUTF8 ));
    //NSLog(@"%@",encodedString);
	
	//default webservice url ----use it as the total str
	NSString *myNewURL = [NSString stringWithFormat:@"%@%@?key=%@",url,methodName,encodedString];
	
    //NSLog(myNewURL);
	
	return [NSURL URLWithString:(NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)myNewURL, NULL, NULL, kCFStringEncodingUTF8)) ];
}


//Previous Method
+(NSURL *)getPRestUrl:(NSString *)url Function:(NSString *) methodName Parameter:(NSDictionary *) params
{
	url=[url stringByAppendingString:methodName];
	
	BOOL firstKey=TRUE;
	for (NSString *key in params)
	{
		NSString *value=[params objectForKey:key];
		if (firstKey) url=[url stringByAppendingString:@"?"]; else url=[url stringByAppendingString:@"&"];
		url=[url stringByAppendingString:key];
		url=[url stringByAppendingString:@"="];
		url=[url stringByAppendingString:value];
		firstKey=FALSE;
	}
	//NSLog(url);
    
	return [NSURL URLWithString:(NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)url, NULL, NULL, kCFStringEncodingUTF8))];
                                                               
}

+(NSURL *)getNRestUrl:(NSString *)url Function:(NSString *) methodName Parameter:(NSString *) params
{
	//keyStr
	NSString *keyStr = @"";
	
	//PART A--fetch up the sys time as the style in 2011-05-29 16:20:51
	NSDate *timeStr=[NSDate date];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
	NSString *partTime = [dateFormat stringFromDate:timeStr];
	keyStr=[keyStr stringByAppendingString:partTime];
    
	//PART B--fetch up the UDID
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *mobile = [defaults objectForKey:@"MOBILE"];
	keyStr=[keyStr stringByAppendingString:@"&"];
	keyStr=[keyStr stringByAppendingString:mobile];
    
	//PART C--compose the value as idenfitier of '|'
	if ([params length]>0) {
		keyStr=[keyStr stringByAppendingString:@"&"];
		keyStr=[keyStr stringByAppendingString:params];
	}
	//NSLog(@"Before cry:%@",keyStr);
	//Encypt the keyStr
	StringEncryption *cry =[[StringEncryption alloc] init];
	NSData *keyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding];
    
	CCOptions padding = kCCOptionPKCS7Padding;
	
	NSData *keyCryData = [cry encrypt:keyData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
    
	NSString *cryStr = [keyCryData base64EncodingWithLineLength:0];
	//NSLog(@"After cry: %@",cryStr);
	//change the url as the urlcode
	NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
																				   (CFStringRef)cryStr,
																				   NULL,
																				   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																				   kCFStringEncodingUTF8 ));
    //NSLog(@"%@",encodedString);
	
	//default webservice url ----use it as the total str
	NSString *myNewURL = [NSString stringWithFormat:@"%@%@?key=%@",url,methodName,encodedString];
	
    //NSLog(myNewURL);
	
	return [NSURL URLWithString:(NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)myNewURL, NULL, NULL, kCFStringEncodingUTF8))];
}


+(NSURL *)getNNRestUrl:(NSString *)url Function:(NSString *) methodName Parameter:(NSString *) params withMobile:(NSString *)mobile
{
	//keyStr
	NSString *keyStr = @"";
	
	//PART A--fetch up the sys time as the style in 2011-05-29 16:20:51
	NSDate *timeStr=[NSDate date];
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
	NSString *partTime = [dateFormat stringFromDate:timeStr];
	keyStr=[keyStr stringByAppendingString:partTime];
    
	//PART B--fetch up the UDID
	keyStr=[keyStr stringByAppendingString:@"&"];
	keyStr=[keyStr stringByAppendingString:mobile];
    
	//PART C--compose the value as idenfitier of '|'
	if ([params length]>0) {
		keyStr=[keyStr stringByAppendingString:@"&"];
		keyStr=[keyStr stringByAppendingString:params];
	}
	//NSLog(@"Before cry:%@",keyStr);
	//Encypt the keyStr
	StringEncryption *cry =[[StringEncryption alloc] init];
	NSData *keyData = [keyStr dataUsingEncoding:NSUTF8StringEncoding];
    
	CCOptions padding = kCCOptionPKCS7Padding;
	
	NSData *keyCryData = [cry encrypt:keyData key:[_key dataUsingEncoding:NSUTF8StringEncoding] padding:&padding];
    
	NSString *cryStr = [keyCryData base64EncodingWithLineLength:0];
	//NSLog(@"After cry: %@",cryStr);
	//change the url as the urlcode
	NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
																				   (CFStringRef)cryStr,
																				   NULL,
																				   (CFStringRef)@"!*'();:@&=+$,/?%#[]",
																				   kCFStringEncodingUTF8 ));
    //NSLog(@"%@",encodedString);
	
	//default webservice url ----use it as the total str
	NSString *myNewURL = [NSString stringWithFormat:@"%@%@?key=%@",url,methodName,encodedString];
	
    //NSLog(myNewURL);
	
	return [NSURL URLWithString:(NSString*) CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)myNewURL, NULL, NULL, kCFStringEncodingUTF8))];
}



@end
