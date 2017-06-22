//
//  ViewController.m
//  Temple list
//
//  Created by VInoth on 5/27/17.
//  Copyright © 2017 Aryvart. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
   
    NSMutableArray * Ary_templelist;
    
    UIActivityIndicatorView *Movie_Indicator;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    Movie_Indicator = [[UIActivityIndicatorView alloc]
                       initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    Movie_Indicator.center = CGPointMake(200, 300);
    Movie_Indicator.hidesWhenStopped = YES;
    [self.view addSubview:Movie_Indicator];
    [Movie_Indicator startAnimating];
    
    
    
    [self Movie_WebservicesCall];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark - Tablview Datasource methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return [Ary_templelist count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"templeListsid";
    
    UITableViewCell   * cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
   
    cell.textLabel.text=[[Ary_templelist valueForKey:@"name"]objectAtIndex:indexPath.row];
    
    return cell;
    
}













#pragma mark - Webservice Call & Web Services Response

-(void) Movie_WebservicesCall{
    
    
    RestCallOBJ=[[RestCall alloc]init];
    
    
    
    
    
    Ary_Webservice_Request=[RestCall ServiceCall:@"" URL:[NSString stringWithFormat:@"http://www.aryvartdev.com/templeopedia/web_service/category"] method:@"GET" postMethodParam:Nil];
    [RestCallOBJ initWithMethodNameRequest:Ary_Webservice_Request delegate:self identifier:@"Alltemplelist"];
}


-(void) ReceivedErrorData:(NSMutableDictionary *) Serverdata {
    //[[ArySharedMethods GetLoadingview ] removeFromSuperview];
    
}


-(void) Received_alltempleList_ServerData:(NSMutableDictionary *) Serverdata {
    //[[ArySharedMethods GetLoadingview ] removeFromSuperview];
    [Movie_Indicator stopAnimating];
    
    if(![Serverdata count])
    {
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Movies"
                                                          message:@"No Data Found"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [message show];
        
        return;
    }
    else
    {
        
        Ary_templelist=[Serverdata valueForKey:@"categories"];
        
        
        
        NSLog(@"%@",Ary_templelist);
        
        
        
        
        
        
        
        [self.Tablelist reloadData];
        
    }
    
}





@end
