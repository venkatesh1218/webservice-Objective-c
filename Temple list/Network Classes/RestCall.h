//
//  RestCall.h
//  UticianApp
//
//  Created by aryvart2 on 01/06/16.
//  Copyright © 2016 aryvart2. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ViewController.h"
@interface RestCall : NSURLConnection
{
    NSString *RestcallIdentifier;
    id DelgateObject;
    NSMutableData *urlData;
    NSURLSession *Session;
    
    
}
@property(nonatomic,retain)NSString *RestcallIdentifier;
@property(nonatomic,retain)NSMutableData *urlData;
@property(nonatomic,retain)id DelgateObject;

+(NSMutableURLRequest *)ServiceCall: (NSString*)ParameterString URL:(NSString *)RequestURL method:(NSString *)ServiceMethod postMethodParam:(NSDictionary *)PostparamDict;

-(id) initWithMethodNameRequest:(NSMutableURLRequest *)urlRequest delegate:(id)delegateArg identifier:(NSString *)checkIdentity;
- (id) initWithMethodRequest:(NSMutableURLRequest *)urlRequest delegate:(id)delegateArg;



@end
