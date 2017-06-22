//
//  RestCall.m
//  UticianApp
//
//  Created by aryvart2 on 01/06/16.
//  Copyright © 2016 aryvart2. All rights reserved.
//

#import "RestCall.h"

@implementation RestCall

@synthesize RestcallIdentifier,DelgateObject,urlData;


/*
 For Make Request
 */

+(NSMutableURLRequest *)ServiceCall: (NSString*)ParameterString URL:(NSString *)RequestURL method:(NSString *)ServiceMethod postMethodParam:(NSDictionary *)PostparamDict
{
    NSError *error;
    NSMutableURLRequest *theRequest=[[NSMutableURLRequest alloc] init];

    

    
        
        
        
        if([ServiceMethod isEqualToString:@"GET"])
        {
            NSData *postData = [ParameterString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
            NSString *urlString = [RequestURL stringByAppendingString:[NSString stringWithFormat:@"%@",ParameterString]];
            urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [theRequest setURL:[NSURL URLWithString:urlString]];
            [theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [theRequest setHTTPMethod:@"GET"];
            [theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [theRequest setHTTPBody:postData];
            return theRequest;
            
        }else if([ServiceMethod isEqualToString:@"POST"]){
            
            
            
            
            NSURL *url = [NSURL URLWithString:RequestURL];
            NSMutableArray *parts = [[NSMutableArray alloc] init];
            for (NSString *key in PostparamDict) {
                NSString *encodedValue = [[PostparamDict objectForKey:key] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *encodedKey = [key stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                NSString *part = [NSString stringWithFormat: @"%@=%@", encodedKey, encodedValue];
                [parts addObject:part];
            }
            NSString *encodedDictionary = [parts componentsJoinedByString:@"&"];
            
            
            NSData *postDatanew =[encodedDictionary dataUsingEncoding:NSUTF8StringEncoding];
            
            // Create the request
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
            [request setHTTPMethod:@"POST"];
            [request setValue:[NSString stringWithFormat:@"%d", postDatanew.length] forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postDatanew];
            
            
            
            return request;
            
            
        }
        else {
            
            
            
            NSString *urlString = [NSString stringWithFormat:@"%@",RequestURL];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString:urlString]];
            [request setHTTPMethod:@"POST"];
            NSString *boundary = @"---------------------------14737809831466499882746641449";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            
            NSString *filename = @"Shareshow";
            NSMutableArray *checking = [[NSMutableArray alloc]init];
            [checking removeAllObjects];
            [checking addObject:PostparamDict];
            
            
            NSMutableData *postbody = [[NSMutableData alloc] init];
            NSData *jsonData2 = [NSJSONSerialization dataWithJSONObject:checking options:NSJSONWritingPrettyPrinted error:&error];
            
            [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@""\r\n\r\n",filename] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:jsonData2];
            [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPBody:postbody];
            
            
            
            
            return request;
            
            
        }
    

}

/*
 For Make Connections
 */
- (id) initWithMethodNameRequest:(NSMutableURLRequest *)IWNL_urlRequest delegate:(id)delegateArg identifier:(NSString *)checkIdentity{
    
    self = [super initWithRequest:IWNL_urlRequest delegate:self];
    
    NSLog(@"ID:%@",checkIdentity);
    RestcallIdentifier=checkIdentity;
    if (self != nil) {
        self.DelgateObject=delegateArg;
    }
    return self;
    
}

- (id) initWithMethodRequest:(NSMutableURLRequest *)urlRequest delegate:(id)delegateArg{
    self = [super initWithRequest:urlRequest delegate:self];
    if (self != nil) {
        self.DelgateObject=delegateArg;
    }
    return self;
}


#pragma mark - JSON Delegate

#pragma mark - JSON Delegate For connectionDidFinishLoading

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //your main thread task here
//        [[ArySharedMethods sharedMySingleton].Ary_view_LoadingBg removeFromSuperview];
//    });
    
    
    NSError *myError = nil;
    NSDictionary* WebserviceResponse = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableLeaves error:&myError];
    
    if ([RestcallIdentifier isEqualToString:@"Alltemplelist"]){
        [self.DelgateObject Received_alltempleList_ServerData:WebserviceResponse];
        
    }    
    
    
    
    
    
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //your main thread task here
//        [[ArySharedMethods sharedMySingleton].Ary_view_LoadingBg removeFromSuperview];
//    });
//    NSLog(@"previous authentication failure:%@",[error userInfo]);
//    @try {
//        [self.DelgateObject ReceivedErrorData:error];
//    }
//    @catch (NSException *exception) {
//        NSLog(@"Exception caught");
//    }
    
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    if(!urlData){
        urlData = [[NSMutableData alloc] init];
        [urlData setLength:0];
    }
    [urlData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    NSInteger code = [httpResponse statusCode];
    [urlData setLength:0];
}

@end

