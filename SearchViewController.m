//
//  SearchViewController.m
//  Liwushuo
//
//  Created by administrator on 15/10/14.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "SearchViewController.h"

#import "SearchLWTableViewCell.h"
#import "SearchLWViewController.h"
#import "WaitSearchViewController.h"


@interface SearchViewController ()

@property(nonatomic)UISearchController*Search;

@property(nonatomic,strong)UITableView*tableview;

@property(nonatomic,strong)SearchLWViewController*sv;

@property(nonatomic,strong)NSDictionary*dic;
@property(nonatomic,strong)NSArray*array;

@property(nonatomic,strong)UICollectionView*collectionview;


@end


@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title=@"搜索";
    
    self.dic=[NSDictionary dictionary];
    
    self.array=[NSArray array];
    

    SearchLWViewController*lw=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchLw"];
       [MBProgressHUD showMessage:nil];
    
    NSString*str=@"http://114.215.126.243/Lee/MyApache-PHP/queryTrade.php";
    
    NSURL*url=[NSURL URLWithString:str];
    
    NSMutableURLRequest*request=[NSMutableURLRequest requestWithURL:url];
    
    request.HTTPMethod=@"POST";
    
    
    NSURLSession*session=[NSURLSession sharedSession];
    
    NSURLSessionDataTask*task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSDictionary*DIC=[[NSDictionary alloc]init];
        DIC=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        
        self.dic=[NSDictionary dictionaryWithDictionary:DIC];
        
         self.array=[self.dic objectForKey:@"info"];
        
        dispatch_async(dispatch_get_main_queue() , ^{
            
            [MBProgressHUD hideHUD];
         
        });
        
        
    }];
    
    [task resume];
    

    



    


       self.Search=[[UISearchController alloc]initWithSearchResultsController:lw];
    
    
//      self.Search.searchResultsUpdater=self;
    
        self.Search.dimsBackgroundDuringPresentation=YES;
    
    
    
    
        [self.Search.searchBar sizeToFit];
    


    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    
    
    
    [self.view addSubview:self.tableview];

    self.tableview.tableHeaderView=self.Search.searchBar;
   
    self.Search.delegate=self;
    
    self.Search.searchBar.delegate=self;
    
    self.tableview.delegate=self;

    self.tableview.dataSource=self;
    
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    
    
//    self.Search.searchResultsUpdater=self;
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    SearchLWTableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"search" ];
    
    
    if (!cell) {
        
        cell=[[SearchLWTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"search"];
        
        
    }
    
    
    UILabel*label=[[UILabel alloc]initWithFrame:CGRectMake(10,-30, 200, 100)];
    
    label.text=@"请输入你要搜索的礼物";
    
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:14]];
    [cell addSubview:label];
    
    return cell;



}

//-(void)viewWillAppear:(BOOL)animated{
//    
//    self.tabBarController.tabBar.hidden=YES;
//}


//-(void)viewDidAppear:(BOOL)animated{
//   
//    self.tabBarController.tabBar.hidden=YES;
//
//  
//}


//
//- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
//
//    
//    NSString *filterString = self.Search.searchBar.text;
//    
//    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains [c] %@", filterString];
//    
//    
//    self.visableArray = [NSMutableArray arrayWithArray:[self.array filteredArrayUsingPredicate:predicate]];
//    UIStoryboard*sb=[UIStoryboard storyboardWithName:@"Choiceness" bundle:nil];
//    
//    SearchLWViewController*sv=[sb instantiateViewControllerWithIdentifier:@"SearchLw"];
//
//    NSLog(@"输入");
//    
//    [sv setValue:self.visableArray forKey:@"DataArray"];
//    
//    
//    [sv.collection reloadData];
//    
//    
//    
//    
//}




- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
 
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{


    
  
    SearchLWViewController*sv=[self.storyboard instantiateViewControllerWithIdentifier:@"SearchLw"];
    
    
        NSString *filterString =[searchBar text];

            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains [c] %@", filterString];
    
    
            self.visableArray = [NSMutableArray arrayWithArray:[self.array filteredArrayUsingPredicate:predicate]];

    
    
    
    [sv setValue:self.visableArray forKey:@"DataArray"];
   
  
    [self presentViewController:sv animated:YES completion:nil];
  
    
    
    [sv.collection reloadData];

}



@end
