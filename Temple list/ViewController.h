//
//  ViewController.h
//  Temple list
//
//  Created by VInoth on 5/27/17.
//  Copyright © 2017 Aryvart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RestCall.h"
@class RestCall;

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    RestCall *RestCallOBJ;
    NSMutableURLRequest *Ary_Webservice_Request;
}
-(void) Received_alltempleList_ServerData:(NSMutableDictionary *) Serverdata;
@property (weak, nonatomic) IBOutlet UITableView *Tablelist;


@end

